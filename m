From: Astril Hayato <astrilhayato@gmail.com>
Subject: Re: [PATCH] gitk: Comply with XDG base directory specification
Date: Tue, 21 Jan 2014 17:40:58 +0000
Message-ID: <CAFysofbwxb23or25vqh_JFLNU7Ksm9ch=YnvaFggPvdU_x2T7A@mail.gmail.com>
References: <1386963996-5481-1-git-send-email-astrilhayato@gmail.com>
	<20140121111041.GC8265@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 18:41:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5fJx-00073Z-O5
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 18:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198AbaAURlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 12:41:00 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:39159 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbaAURk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 12:40:59 -0500
Received: by mail-lb0-f169.google.com with SMTP id q8so6202001lbi.14
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AQk/OZB+5EZ6GaZ4kwldYRSRSUBAIvpEL3dy0U6ENCY=;
        b=n2dTfMzKovRoWUzKG1AiVpJFFLETpQ1JnvbU+Wmh1bY+hUiCxZyEhF/FMVTIK6LsF3
         +ddUqPtd915jD1lT6ahhQrBgIHl7RCkH2d2Vshp/tojfwlX1sBOxmUrZq8T6gpsIMxZJ
         MfeigvHtQtvIWXnhj1eBlzI1a423+sE/eHnNI+vPKiXaECySl9NF0yCUa/0iqDjHffyg
         Iu6hIZmd/Rmnf37/tP1R4HRjAdeP5ZEdVoBCmUBtRl4LQ2S+I01+qtajs103Fy8f2bzv
         pfRde1TA6224ULt6zgzCt6UZGra8KhiyUn4taeARvtrflY9rTB0nFDH6J88E+7KrdcT3
         X5yg==
X-Received: by 10.152.23.3 with SMTP id i3mr44242laf.78.1390326058277; Tue, 21
 Jan 2014 09:40:58 -0800 (PST)
Received: by 10.114.160.239 with HTTP; Tue, 21 Jan 2014 09:40:58 -0800 (PST)
In-Reply-To: <20140121111041.GC8265@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240759>

On Tue, Jan 21, 2014 at 11:10 AM, Paul Mackerras <paulus@samba.org> wrote:
>> +    if {![file exists $config_file]} {
>> +     if {![file exists [file dirname $config_file]]} {
>> +         file mkdir [file dirname $config_file]
>> +     }
>> +     # for backward compatability use the old config file if it exists
>> +     if {[file exists "~/.gitk"]} {set config_file "~/.gitk"}
>
> Don't we need to set config_file_tmp here too?

Yeah it's probably best to keep the two files together.

>
> And, do we really want to create the ~/.config/git directory if we are
> using the old-style ~/.gitk as the config file?

Probably not. I'll prepare a new patch restoring the old behaviour.

Regards,
Astril.
