From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 2/2] blame: use different blame_date_width for
 different locale
Date: Tue, 22 Apr 2014 20:16:02 +0800
Message-ID: <CANYiYbE5zdOq6F4YwSUojOyp9eexuM8=dY_T4hyd4W+Dea+XUg@mail.gmail.com>
References: <cover.1398010052.git.worldhello.net@gmail.com>
	<07e4dcdc98b5eb9c78b9ed53bf2adc3b33139b67.1398010052.git.worldhello.net@gmail.com>
	<7vbnvvllx4.fsf@alter.siamese.dyndns.org>
	<87vbu1ptsx.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:16:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcZcQ-00012j-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 14:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbaDVMQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 08:16:06 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33826 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbaDVMQD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 08:16:03 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so3142191wib.5
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t4rZo5351SntD5m9unq6fFhmc0TrEL7qjEq1XIm8coU=;
        b=macDUVjHwIQs8maFsMos1QojEJ8x1MzjecSr/pJ2JU8hFc29mew0q3ydyXMM+9Hfwt
         x5BDbbFNDkNHeeTE1Etx1ySD12CiAbK7zof8z5x1DTtBH7jzPvC4EhriAseH1unnZfPQ
         aS4uB83v95L59EtDMMrnN0sxd273nnLjlVIlFRtEmuvxm0pvVEoN10G7af3d2u5vHy8V
         XEmYWNADKLGuJSRDak5kSSXYMcOXtss+JCbnpc6Y/kfOchu2hPTEtE3vHk7rCD1JodpK
         HWMCskUFZBs3BG3WCmTBT/teKmb1Tc4ElQstZcoYFevaJPsqzBJpY9gxuNUi8XBl9o05
         ubsQ==
X-Received: by 10.194.220.42 with SMTP id pt10mr2579665wjc.60.1398168962039;
 Tue, 22 Apr 2014 05:16:02 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Tue, 22 Apr 2014 05:16:02 -0700 (PDT)
In-Reply-To: <87vbu1ptsx.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246732>

2014-04-22 18:01 GMT+08:00 David Kastrup <dak@gnu.org>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> This is not wrong per-se, but I am not sure if translators would
>> understand that "years and months ago" may not be the longuest
>> variant for their language and they are asked to use "89 seconds
>> ago" if the translation of that is longer than the translation for
>> "4 years, 11 months ago" in their language, with the given
>> explanation.
>
> What's with the 89?  And the other semi-magic numbers?

Not something magic, just what show_date_relative() in date.c is implemented:

    98          diff = now->tv_sec - time;
    99          if (diff < 90) {
    100                 strbuf_addf(timebuf,
    101                          Q_("%lu second ago", "%lu seconds
ago", diff), diff);
    102                 return;
    103         }
    104         /* Turn it into minutes */
    105         diff = (diff + 30) / 60;
    106         if (diff < 90) {
    107                 strbuf_addf(timebuf,
    108                          Q_("%lu minute ago", "%lu minutes
ago", diff), diff);
    109                 return;
    110         }


-- 
Jiang Xin
