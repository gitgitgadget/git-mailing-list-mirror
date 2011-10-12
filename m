From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Make is_gitfile a non-static generic function
Date: Wed, 12 Oct 2011 14:01:02 -0400
Message-ID: <CABURp0p4_oVMmkFDPue4kvhO_bEr_dBh-XFGArdSJFMz-Eboeg@mail.gmail.com>
References: <4E94C70E.3080003@cisco.com> <4E94C8AB.3040807@cisco.com> <7vipnvccso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:01:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE37R-0002ln-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab1JLSBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:01:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50181 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab1JLSBY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:01:24 -0400
Received: by wwf22 with SMTP id 22so433849wwf.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=feAB3Ke7h31VSEUPidIWUrR8lR/pzbrr9w6yqcoMTcM=;
        b=sf9xUz2mGKxidon2IUfrkJBmwoeWe2jTLROjEcY/2hBAVvlufI0lFTbeW79+b/GBJg
         cKQ8p3Uq6Fb6uBYQKE5naYfc7udiEtRAT9d8BWVcipotsnLPbsx9FMOejwvdjCuXtKKQ
         irjUAqYh0xNXTuSt5s5HnrSf/+tAjBq/1vo1I=
Received: by 10.216.14.97 with SMTP id c75mr2845263wec.102.1318442483076; Wed,
 12 Oct 2011 11:01:23 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Wed, 12 Oct 2011 11:01:02 -0700 (PDT)
In-Reply-To: <7vipnvccso.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183381>

On Tue, Oct 11, 2011 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> After looking at this patch and the way the other caller in transport.c
> uses it, I am more and more convinced that "is_gitfile()" is a stupid and
> horrible mistake.

I think I misunderstood your objection before.  Now I think I
understand.  Tell me if I am right.


I think you mean that instead of this:
        } else if (is_local(url) && is_file(url) && !is_gitfile(url)) {

you would like to see this:
        } else if (is_local(url) && is_file(url) && is_bundle(url)) {

Or maybe even this:
        } else if (is_bundle(url)) {

Phil
