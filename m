From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according to git-log rules.
Date: Wed, 22 Oct 2008 12:35:17 +0400
Message-ID: <bb6f213e0810220135hd520f78odb83414c248a15e4@mail.gmail.com>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com>
	 <20081022082016.GA18473@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:37:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZDE-0006gJ-22
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYJVIfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbYJVIfV
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:35:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:42839 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbYJVIfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:35:19 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1363496nfc.21
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 01:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bEh72kaZfSwJnJHvxt9CretG1hdSUUXQxkylI5GtrW0=;
        b=ChR4ONaSmRngeV7GWBaujRmpSl1OfPhFNWfCwwwiVBqZkh0xZkV/fM4xQgDoCk91TG
         DvnFEnsEV0NZav6H6w4TFoHum2mGTcDb4jNdE3hnxaL5sMb3mvf45Bc4LAVEap8RxPpS
         pTk9smYygKCdEQkzVpEY5SxOPdzAc4CIpn6lU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jcnA08j5A8KmCBNmbDWYZ8yWWd0aYC/8EHKVFC+tLY9BY7u7TdWJ8jOSQE01FMn1dc
         d7PmHlCQXL6cu7R6xpBhQwB5T3hloH/j51s3Ig5qjYNCAUGSHvRRj3M8/2cAdaYKJFj0
         Sojca+2GU6go6lZCX6ZeCrJ5Mi73opojzVZ8U=
Received: by 10.103.211.3 with SMTP id n3mr5007886muq.43.1224664517528;
        Wed, 22 Oct 2008 01:35:17 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Wed, 22 Oct 2008 01:35:17 -0700 (PDT)
In-Reply-To: <20081022082016.GA18473@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98847>

On Wed, Oct 22, 2008 at 12:20 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 22, 2008 at 12:55:57AM +0400, Alexander Gavrilov wrote:
>
>> +test_expect_success \
>> +     'blame respects i18n.commitencoding' '
>> +     git blame --incremental file | \
>> +             grep "^\(author\|summary\) " > actual &&
>> +     test_cmp actual expected
>
> Even though it is POSIX, using backslashed grouping in 'grep' isn't
> portable. It fails at least on Solaris 8, and you have to do:
>
>  egrep "^(author|summary) "
>
> instead. Of course, I can't get your test to pass even with that change,
> but I think that is just a broken iconv on Solaris.

Hm, which of the conversions fail? You can try manually converting the
txt files with the iconv command to figure it out.

Alexander
