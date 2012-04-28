From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Bug in git-stash(.sh) ?
Date: Fri, 27 Apr 2012 20:16:11 -0400
Message-ID: <CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
	<xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eli Barzilay <public-eli-oSK4jVRJLyZg9hUCZPvPmw@plane.gmane.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 02:16:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNvKk-0005p1-NL
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 02:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047Ab2D1AQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 20:16:13 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45050 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752895Ab2D1AQN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2012 20:16:13 -0400
Received: by lahj13 with SMTP id j13so871755lah.19
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 17:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=KZPGD0ve9Iv+qCFTJ9iY4N7u2/Z4FUeOk0bF/QuvN6M=;
        b=iMND0eTntxehuVdPVIPOWkhyoHYtpyov57Ify5pIJ4U8hhCUe+8XRj56U9g6STNcY6
         UNvJDwXDV1IrPAMw+dOr54Frr/BxNYVZfUS1gJ+OQdbd0wYN/PwbK4Yu9mlZbBPZn+G9
         ZwiAalM9/+8WRD/Sw6HPWAZH2NaX55H6EDaaOQtfKYJ3RICF7O2ZWZQ93B+EN1vcWds1
         +GmAJE8QtHdb1A6x2LYv2VI9DcnKa3slO/fSd5k63mnxzRW23JxDCIHu0H5EBYvOu0IR
         DFHz+0aViWRBcNWupXgxSSUNvtqeZoCtlA6X8/ymanAs4hHmUW1l5a9yGO8DXerYQk+V
         4K0w==
Received: by 10.152.146.129 with SMTP id tc1mr1825629lab.27.1335572171458;
 Fri, 27 Apr 2012 17:16:11 -0700 (PDT)
Received: by 10.112.81.201 with HTTP; Fri, 27 Apr 2012 17:16:11 -0700 (PDT)
In-Reply-To: <xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
X-Gm-Message-State: ALoCoQmZVNqxtTCaOhlW2qSMT/nM29KDyFxoeN5+YybkB6EUUMcYAAJjca/0udHHZs92l4RQ1AZ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196491>

On Fri, Apr 27, 2012 at 19:02, Junio C Hamano <gitster@pobox.com> wrote:
>
> Not surprised; as far as I understand, ever since the original design,
> the stash entries are meant to be _counted_, i.e. stash@{0},
> stash@{1}, stash@{2}, ... and never timed.

Ah, that's an issue for magit, but I'd rather have it working anyway.


> I do not mind a fix, but I would prefer a solution that does *not*
> involve $IFS hack that would not work with a string with LF in it.

I didn't like that either, and I think that it's possible to avoid it by
dropping the --symbolic for that test, and re-parse if needed for an
error messag.  I'll try that and send a patch.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                  http://www.barzilay.org/                 Maze is Life!
