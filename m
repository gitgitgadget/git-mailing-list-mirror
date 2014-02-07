From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] gitweb: Added syntax highlight support for golang
Date: Sat, 8 Feb 2014 03:26:05 +0530
Message-ID: <CAK9CXBXXge+ZGN_ocWMH5jkPJcTg74rhtWsDiOuqAeeGXDW_tg@mail.gmail.com>
References: <1391807441-23049-1-git-send-email-pavan.sss1991@gmail.com> <xmqqiosqtwqk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:56:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBtPS-0002VK-9R
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbaBGV40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:56:26 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:64956 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaBGV4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:56:25 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so6160320qac.17
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qn5sIweVdTlvVQASL+AwQfJnbpZKUVOf4qvJ/xBVBGU=;
        b=eZDIH2s6ZwQuVmcifA5f87nByr9WCFEtcFzQm7PSoHdZ5+hxihUBhwT/vH74wxoA7N
         rSIzMVxu9j4UpW1kLLR4H/jyVZiJjk1iiy2Yk3RgS7AQxXch62TOUtdLgxcTT4bJQEo+
         mWuuZZK9LulOuQ0y8+0XEmYaRDn20PNjc1vAtK9UjlIfEb9fBBwWbLdt/3zC9XACHJYz
         DaOk9NULWrXyXwxN+Eio/qRnkDXjEBF1iPpL2zVBc37yZO3Yg7FSWbXQt0PizHQjDroK
         ArWBcpo665RTZwt1HYtEyK0WeO+dgvCcs00iUYAKpWaWzwJaoGNQRnhdWrH9wWHukVQD
         PPgQ==
X-Received: by 10.140.31.75 with SMTP id e69mr24922045qge.76.1391810185058;
 Fri, 07 Feb 2014 13:56:25 -0800 (PST)
Received: by 10.224.121.211 with HTTP; Fri, 7 Feb 2014 13:56:05 -0800 (PST)
In-Reply-To: <xmqqiosqtwqk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241807>

The highlight project which is being used by gitweb supports this. I
checked it before submitting the patch.

Thanks

On Sat, Feb 8, 2014 at 3:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:
>
>> Golang is quickly becoming one of the major programming languages.
>>
>> This change switches on golang syntax highlight support by default
>> in gitweb rather than asking the users to do it using config files.
>
> Looks trivially harmless ;-)
>
> I haven't touched this part of our system, but the patch makes me
> wonder if there is a way for us to _ask_ the installed 'highlight'
> binary what languages it knows about.  This hash is used only in
> guess_file_syntax sub, and it may not be unreasonable to populate it
> lazily there, or at least generate this part by parsing output from
> 'highlight -p' at build-install time.
>
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>> ---
>>  gitweb/gitweb.perl |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index bf7fd67..aa6fcfd 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -273,7 +273,7 @@ our %highlight_basename = (
>>  our %highlight_ext = (
>>       # main extensions, defining name of syntax;
>>       # see files in /usr/share/highlight/langDefs/ directory
>> -     (map { $_ => $_ } qw(py rb java css js tex bib xml awk bat ini spec tcl sql)),
>> +     (map { $_ => $_ } qw(py rb java go css js tex bib xml awk bat ini spec tcl sql)),
>>       # alternate extensions, see /etc/highlight/filetypes.conf
>>       (map { $_ => 'c'   } qw(c h)),
>>       (map { $_ => 'sh'  } qw(sh bash zsh ksh)),



-- 
- Pavan Kumar Sunkara
