From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-rebase: fix probable reflog typo
Date: Wed, 23 Apr 2014 16:22:59 -0500
Message-ID: <53582f33385bc_24448772ec57@nysa.notmuch>
References: <1398212084-16304-1-git-send-email-felipe.contreras@gmail.com>
 <vpqy4ywxoos.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:33:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4nK-0000EA-H2
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbaDWVd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:33:26 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46146 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaDWVdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:33:25 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so1684163oag.39
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=fRKNm4+mm9DqnDXZj2cXC70hT05kioq54d/ZwkNVjc0=;
        b=EOIScl2ZPehAZj79RpYPWFaOJ5PQElF60wVUiR23CbSMlGCUpptJaEdAuLhRkVcdgv
         iZiS5zOCRqlLL0wn/bS57tHFB01QG1Lt4AYg6DWnXm6sVv0PcEGVzL1Y9atEyTMVY02A
         wJARlWW0YI71WTa2x5U2jEarY8myj9VIadQOoZxqP7WJA6AZ4pSJqO7syACrOapPXQeF
         yUkZjjeiSupZkhReg9t8VMS2atbnzCbGXgnVuFX5Qg1CQVwmz4s6/qyKDhlp2V7X+N1E
         Uohm9+Y+H1RWPMcHSNVtzFdCdMaE24R4xNLlZM2FpRcJJT4guKeTVTOzW48GrA51farr
         Pnpg==
X-Received: by 10.182.24.69 with SMTP id s5mr40450727obf.35.1398288804616;
        Wed, 23 Apr 2014 14:33:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f9sm4203514obm.2.2014.04.23.14.33.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 14:33:23 -0700 (PDT)
In-Reply-To: <vpqy4ywxoos.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246903>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Commit 26cd160 (rebase -i: use a better reflog message) tried to produce
> > a better reflog message, however, it seems a statement was introduced by
> > mistake.
> >
> > 'comment_for_reflog start' basically overides the GIT_REFLOG_ACTION we
> > just set.

> So, one needs to reset $GIT_REFLOG_ACTION to what it used to be if is it
> to be used later. However, it seems to me that the "comment_for_reflog
> start" is used only for this checkout command. If so, there's no need
> for the "comment_for_reflog start" before the if statement either.

Exactly. But if this variable is only meant for this command, it should be
`VAR=VAL command`, that would make it clear without the need of a comment.

-- 
Felipe Contreras
