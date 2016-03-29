From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 1/7] Make it possible to get sha1 for a path from the index
Date: Tue, 29 Mar 2016 20:31:00 +0700
Message-ID: <CACsJy8DqN+s2inEeO++hcen1MH+9Op_DFG2x6n8D4xuVfgAu8w@mail.gmail.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com> <1459257930-17193-1-git-send-email-tboegi@web.de>
 <CACsJy8A-nwv2B=6B4TqAz+i=DxC6Wu5yO924uaXWd5zLuXFRTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 15:31:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktk8-0005B1-O1
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbcC2Nbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 09:31:33 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32968 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbcC2Nbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 09:31:32 -0400
Received: by mail-lf0-f49.google.com with SMTP id g124so9535351lfg.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s0CY4AQxTOOlxDtSTF12qGzZ90G6W7FLRTeVAQzFCmY=;
        b=uOzTBF9ehNmMMf37QCLn+pV4ADhvgMDmPFAZmFRc7UjgMAiZIrZGgWhSpXdxwqeLHP
         idyMobF5HiX1aqutOg57Is7QJQhkmRpLgZ36Fz39t8ulA4hdHcBpCCbj1l74tFvj8cw2
         51bEkkhCeLb0W0o3AsL062nS5FCTmHciQOr/LkSkN6ou6fzfMPX8ih1FQN6Tik8fUGzB
         zM5PWpQR2RpH47Lk9N5P8gYSWPZyiGq+dlPofqJZvw+01GWLHJ0KFoG6K1pvUEboUsgI
         IwY9In30Q6De12su8hGRSZ1pPmcdku9TRkTBZFFBq2ac1HvaSx9aK/u1nz1DdO62MQVP
         tz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s0CY4AQxTOOlxDtSTF12qGzZ90G6W7FLRTeVAQzFCmY=;
        b=LDdJVpMKkUzbJpNbe260bVDw0DZkJxFYMLqw7ty0emrkM9g7wuuCuz3SXem/Gu9ROz
         y13ftQoZsuLDLz9tqI3+SdyYCA1f3ICtLYHgpH8JdcDM5DxijvQ+kzx9FtDSLp0H0Ep+
         eT/nF6uLRZN4E1tIWmLPD6wUsbHLek7qTq4ZnpYI7NXCQ16dfkUnIWn7BLMcDmO02qIE
         JXLuS4Kh/JGfWcc3BJGOKdPvGylS35OZEIDupf1HcNLTSJeg6KgujE/lbxXkZeF4V9GR
         uyfpyT1CgxXbxZhNEqEArJs9wHNBHpZtw4MN3KybnWMP3zrcaLBMsHUk3KFSQib/HyQQ
         4+dg==
X-Gm-Message-State: AD7BkJIDeh+D700TmQEh4+TiFmJ5EAWdMM1DfrMcNTzYTWvTPr7wdQrK9qghdToSg5ZB0phXC1OQu8rM8SC9/w==
X-Received: by 10.25.147.202 with SMTP id v193mr1167716lfd.162.1459258290206;
 Tue, 29 Mar 2016 06:31:30 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 29 Mar 2016 06:31:00 -0700 (PDT)
In-Reply-To: <CACsJy8A-nwv2B=6B4TqAz+i=DxC6Wu5yO924uaXWd5zLuXFRTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290137>

On Tue, Mar 29, 2016 at 8:28 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Mar 29, 2016 at 8:25 PM,  <tboegi@web.de> wrote:
>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> Factor out the retrival of the sha1 for a given path in
>> read_blob_data_from_index() into the function get_sha1_from_index().
>
> Getting _sha1_ from index is one function call and a memory
> dereference or two. I think you mean get sha1 _file_ (or data) from
> index. Maybe put either word in the function name.

Oops, shouldn't have trusted that function name in the @@ line. No
what you write in the commit message matches the patch. Sorry for the
noise.
--=20
Duy
