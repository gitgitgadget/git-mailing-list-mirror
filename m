From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: global hooks - once again
Date: Tue, 6 Jul 2010 14:14:20 +0200
Message-ID: <AANLkTimSvwo50Q9jsbKkzvplSPE82fNJJDSFmZVw3r5o@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
	<AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 14:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW72i-0000px-MA
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 14:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118Ab0GFMOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 08:14:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63351 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab0GFMOW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 08:14:22 -0400
Received: by gxk23 with SMTP id 23so2893560gxk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 05:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=FzSWXTrjvSejbmGkGz2GT1mO7yl584jGwuuTE97f8Rw=;
        b=Td24S3NDN2AjzX89qXiJSyYQ6Ygf8OY+WFhCcmFz6d6ViTWChkWeW93JRHkc21/UMW
         cFzNKKM1CTPYO/JAlMXC65PEYcTfRV2jeNJVz/LoToZC6jTCGhOY/0Bol2GIYdsRJWpe
         SYo0V6Wdr9WJS9reSv6E41+GXbtXkk+cCc98o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Eu9RKMCnnhM+UceaCCHxpZXTd4UKx9d2naIpy5J21M4YRP0ZlRLrYxP+xgDf9gjG9G
         b7sqpxPXu1CbBrBj4x0oc3GTX5U3pPN1nGPIAVsqi+4d568+2lVLg3rd1wWfdY2cZbFT
         8Ti++P1FCe7/nLceO4U1g0iXjUXqZbEKmrljk=
Received: by 10.213.20.80 with SMTP id e16mr3850966ebb.32.1278418460479; Tue, 
	06 Jul 2010 05:14:20 -0700 (PDT)
Received: by 10.213.112.208 with HTTP; Tue, 6 Jul 2010 05:14:20 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150345>

On Mon, Jul 5, 2010 at 12:03, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> So what I have done is setup a template directory with hooks being
> a link to a pre-installed directory, where each hook is linked to a
> single script. This script then reads from a directory called
> hooks.d which is a drop directory for hooks. Each hook then has the
> format '<hook>.<order>.<name>' (e.g., 'post-receive.10.send_mail'),
> somewhat similar to /etc/rcX.d. It will also look in a .githooks.d
> directory in the working directory (this can be disabled with a
> config option). This is used by repository owners who want to add
> extra hooks for their repositories, e.g., to add automatic code
> indentation before commit, or unit testing. It is also possible
> to specify more hook directories with a multi-value config option,
> which the user can use if he/she likes to add some personal hooks.

How do your users disable execution of global hooks in this scheme?
(to protect themselves from an evil system administrator)
