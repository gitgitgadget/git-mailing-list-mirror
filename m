From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] Smart-http documentation: add example of how to execute 
	from userdir
Date: Sun, 27 Dec 2009 23:18:42 -0500
Message-ID: <905315640912272018r1282394fh62d37b5c9e91a234@mail.gmail.com>
References: <1261847255-13970-1-git-send-email-tarmigan+git@gmail.com> 
	<be6fef0d0912261919m7b175c4fh532ad05a713d86c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 05:19:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP74a-00033E-H2
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 05:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZL1ETG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 23:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbZL1ETF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 23:19:05 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:36938 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbZL1ETC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 23:19:02 -0500
Received: by pzk1 with SMTP id 1so2638440pzk.33
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 20:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=K/P6CoN+vEgY7iZQBPbPE6wTxFvoX4WVJ2hFa9pB5XU=;
        b=OwKaM/XW8z96co2ZJVEyGtSwPK+B/T0Qg+kb0CYJ9RXvWA7XNN4fh+tvUcdJ3fSPdY
         kJoD9e7NlFmCWAirx9LthlWUuMdpl6rj/4FPFwjvJ3jJCl34E9iM59pOokrIDwQstEmI
         0NLctfbUHd/qJtydb22+sAeEAnuVCR1W60Kr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=YrNFFS9nEOLyzJ1TqQP6T+XE679gUQBOYtPwNXbcEZuI2KlW1AUMdyUf0Fmb7A1OsF
         S/PoQXeKgd4HWCsHr9D0irBckWvLX42ZdBYb5SHEwN0MsCauR9xLVGL40F3JbL4yN9Q8
         ZBU6MqmO7PcbHbtuzzJ3/mk+aHK2iq4iDdIAw=
Received: by 10.143.129.7 with SMTP id g7mr10265147wfn.43.1261973942147; Sun, 
	27 Dec 2009 20:19:02 -0800 (PST)
In-Reply-To: <be6fef0d0912261919m7b175c4fh532ad05a713d86c7@mail.gmail.com>
X-Google-Sender-Auth: 9cd736b04f38d64e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135724>

On Sat, Dec 26, 2009 at 10:19 PM, Tay Ray Chuan <rctay89@gmail.com> wro=
te:
>> -All of the following examples map 'http://$hostname/git/foo/bar.git=
'
>> -to '/var/www/git/foo/bar.git'.
>> +Unless otherwise noted, the following examples map
>> +'http://$hostname/git/foo/bar.git' to '/var/www/git/foo/bar.git'.
>
> This rephrase seems to be unrelated (to providing an example of
> serving smart http).

I think this change is related because previously all the examples
provided the same mapping.  With the new example with a different
mapping, the "_All_ of the following" is no longer true.

>> @@ -144,6 +144,42 @@ ScriptAliasMatch \
>> =A0ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
>> =A0----------------------------------------------------------------
>>
>> +In the following example, a repository at
>> +'/home/$username/devel/foo/bar.git' will be accessible at
>> +'http://$hostname/\~$username/cgi-bin/git/foo/bar.git'
>> +
>> +From UserDir on Apache 2.x::
>> + =A0 =A0 =A0 One way to configure 'git-http-backend' to execute and=
 serve
>> + =A0 =A0 =A0 from a user directory (for example, on a shared hostin=
g
>> + =A0 =A0 =A0 provider), is to have a symbolic link that points from=
 the cgi
>> + =A0 =A0 =A0 directory to the 'git-http-backend' executable in libe=
xec. =A0The
>> + =A0 =A0 =A0 advantage of the symblic link is that any updates to t=
he
>
> s/symblic/symbolic
> s/update/updates/.

Thanks.

> At this point, the user dealing with the "easy" case (ie. the user
> just symlinks the shared git installation and doesn't have to create
> symlinks in his own home directory) should have enough configuration
> details without having to read any further. So, you could tell the
> user about the symlinks to create and the configuration lines in
> .htaccess.
>
> It might also be a good idea to start a new paragraph for the "hard"
> case, for better readability.

OK, these suggestions sound good to me.  I'll send out an updated patch=
 shortly.

Thanks,
Tarmigan
