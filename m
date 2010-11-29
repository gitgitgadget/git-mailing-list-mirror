From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3] help: always suggest common-cmds if prefix of cmd
Date: Mon, 29 Nov 2010 17:53:25 +0100
Message-ID: <AANLkTim_TiC-CSGz6x4cH44meJ6SpQv0sg3-rVWsDcKK@mail.gmail.com>
References: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
 <1290787239-4508-1-git-send-email-kusmabite@gmail.com> <7voc9bpqj2.fsf@alter.siamese.dyndns.org>
 <AANLkTin34AfYnFY5e9B1cuyckfLXU2=qXFciFaaNGt9f@mail.gmail.com> <20101129164049.GH8037@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	ziade.tarek@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 17:54:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN6zn-0000pg-0Y
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 17:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab0K2Qxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 11:53:47 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45115 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab0K2Qxq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 11:53:46 -0500
Received: by gxk1 with SMTP id 1so153253gxk.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 08:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=7WzIwli2eyP6A5/RadU+Veve95enung1A01yXvCe12o=;
        b=yIUIHVYiTwqb8rqj1yDYGExmT5LZAVOg8B9oI3sz5UYXdVxA8FoZ2H0wWC0e8in9v0
         n6vfC7sjSmrmS1iLT2KSmOj0v8qSgWm68i+F1BpM/yMM4LZ05jVw+JvCy+0v56jH9uxC
         cuV96RkHdHm9f8X0iAde/B33HRUjde3Lwyx6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=uq3f0ITnjDcHLWKEp0Klotu51GyfPIXm3Nr74d4IbdhbTH1FRLJlbvU/TVdscZiRqq
         DsjFJkJReNf56p9KuYLTCK9O0/VRxnO6lDqKgwlnGHL5jJdwRTE2tN4Zgy56ws4Ry3JV
         2mOtx140GYzVlMOfyyckwx01Atjll6nER1gmQ=
Received: by 10.223.79.72 with SMTP id o8mr5555444fak.83.1291049625431; Mon,
 29 Nov 2010 08:53:45 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Mon, 29 Nov 2010 08:53:25 -0800 (PST)
In-Reply-To: <20101129164049.GH8037@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162402>

On Mon, Nov 29, 2010 at 5:40 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> For this code-path to trigger we would have to be able to prefix-mat=
ch
>> every common command AND every "main command" must be included in
>> common commands. At the same time. The only possible way to
>> prefix-match all commands is if they all start with the same letter.
>> Do you really think this is a situation we could ever end up in? Eve=
ry
>> git command being a common-command, starting with the same letter?
>>
>> This is basically unreachable code. Perhaps it'd be even clearer jus=
t to die:
>>
>> if (main_cmds.cnt <=3D n)
>> =A0 =A0 =A0 die("Prefix-matched everyting, what's going on?");
>
> (I haven't checked.) =A0Maybe
>
> =A0 =A0 =A0 =A0$ git ""
>
> ?
>

Ah, yes. This does indeed work, both on Linux and Windows, and it does
weaken my point about the unlikeliness of the code ever reaching it.

But I must say that I think the most sane thing to do in this case
would be to just display the normal help-page (like "git" does).
