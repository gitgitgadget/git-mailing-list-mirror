From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [bug] Graph log and orphan branches
Date: Wed, 30 Dec 2015 21:43:29 +0100
Message-ID: <1451508209.9251.13.camel@kaarsemaker.net>
References: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
	 <xmqqziwremqh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Carlos Pita <carlosjosepita@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 21:43:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aENaq-00012n-L0
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 21:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbbL3Une (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 15:43:34 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36791 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983AbbL3Unc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 15:43:32 -0500
Received: by mail-wm0-f47.google.com with SMTP id l65so70015617wmf.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 12:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=/j3Rd13a3NQ4jzZr8xdx2CDJTKRs+mykPOsmfnCtUJg=;
        b=oIhS3fjUh46rT0tIeZ/pAmqca0+v4oisaMl/A9kKdm5NdYv5i//f25WcShkyyESSa8
         L3W3HELn2DT0q04r5tf6jimMr7ADfckUUbKgIfIhQdV9GODjM+DNHRIfwAc03UsbkDJi
         wpXn3nZRR4X3n4yCtBIcoeFezQonTXSyBU6ABIBknAc9ibI+a8iOz5+Ky5XIr6hNOi0u
         PsbBT44MCp54aX7WWXQlN4eJ5P3Z+xBCyRi5u22374x9tk7uG6Ncif6JVVWzP0ZLikgX
         KxsF1d09zHOcjouLq8IClMOnABlWu8a+x74yPRRpjjVoifinpffY1tUMRu1SSjbnveUJ
         lw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=/j3Rd13a3NQ4jzZr8xdx2CDJTKRs+mykPOsmfnCtUJg=;
        b=UDJRsf0EjsdUIPJUm8Uj11IJK6O2naN9gFR4Ekq/axPTs7fnARq0SdkeGATGsplVbj
         BpIExFYGIun0LftT0oMvQLbCAt5GNH5o333AFYf1k5EB8/hxcfpALwy1BRqnCPeggvU9
         ldhNOYoWszN/6sUGwZVc3B9rTaJ4Yhx7lEIEXjnd79qn6iqNlwvb+FsLD1IYTinN7x3F
         USr85+8hApAUP+JkP9H1+TOmGnJYzw7/Gjv5nYWEWu+BYLnfRh/cw/JldKTHluxgV1yO
         z1kaNTTK2iy8YdYl7QBHTIwlsTTJv9Yns/dIW0krpie0IxMKlph2P49CSndqGfSf+cBw
         Fnjw==
X-Gm-Message-State: ALoCoQmIkGkVi8ontHKdUnE/Kai7AwIEv5NBFWYV225ZuoAYl+8ndi/R48oln7gl2TvOSdzcXZnWfVCA7Pmv5rGDL+me1wi85A==
X-Received: by 10.194.201.134 with SMTP id ka6mr72952945wjc.116.1451508211324;
        Wed, 30 Dec 2015 12:43:31 -0800 (PST)
Received: from [10.42.1.4] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id w1sm47987171wmd.2.2015.12.30.12.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 12:43:30 -0800 (PST)
In-Reply-To: <xmqqziwremqh.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283196>

On wo, 2015-12-30 at 11:54 -0800, Junio C Hamano wrote:
> Carlos Pita <carlosjosepita@gmail.com> writes:
> 
> > the graph output of log show orphan branches in a way that suggests
> > they have a parent.
> 
> Reminds me of this ancient RFH topic
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/236708/focus
> =239580
> 
> which unfortunately got no help...

Instead of a blank line, why not something like this to make root
commits stand out a bit?

diff --git a/revision.c b/revision.c
index 0a282f5..e69a992 100644
--- a/revision.c
+++ b/revision.c
@@ -3346,7 +3346,7 @@ char *get_revision_mark(const struct rev_info *revs, const struct commit *commit
                else
                        return ">";
        } else if (revs->graph)
-               return "*";
+               return commit->parents ? "*" : "^" ;
        else if (revs->cherry_mark)
                return "+";
        return "";

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
