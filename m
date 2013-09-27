From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug: [hostname:port]:repo.git notation no longer works (for ssh)
Date: Fri, 27 Sep 2013 20:48:18 +0700
Message-ID: <CACsJy8CURVVpdGGJgpG2abJ3yo+fEnbeXS1Dug4zPCJ=zMLxmQ@mail.gmail.com>
References: <87vc1mg01t.fsf@aeneas.oslo.osa> <524547E8.4070406@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Morten Stenshorne <mstensho@opera.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 15:48:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPYPe-0005OP-26
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 15:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab3I0Nsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Sep 2013 09:48:50 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:48132 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845Ab3I0Nst convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Sep 2013 09:48:49 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so2068208oag.0
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TyQkn5w5NOaYHl4k+93s+h46rXL562xJ5aUHXmOLe2E=;
        b=FYVEoB58LdMmD0cY2FXM3WqlYD5pfDcPFFTw4uydgxW9Age6mAjXjc3L2s/KsjAoBQ
         hTkSc9y6/DVnww16og5UJ5osI5goExMPggan3pd0iPJ2H5ony5p1Z7GmttbEc0EZgIn+
         2LEGOP3suTXMnu9lbkAjshrTZHT/2Xw6pFm/9ZIka8p8GxhPl7wUQzasuXNNcHVQI8Ga
         q5rBNrLDY6m8XVpzTdy7MYw5EGgPhCdO1WcrWSnNjA3SlvBeoBfLp2F4iaHPQ8pr4Ypy
         DO+cdUwBGD1hjY+AAQtxxhYP0nMs/7svtd0s+EpQE190vJO5tN274/urzGlwLhRcjM2a
         8S8A==
X-Received: by 10.60.50.168 with SMTP id d8mr579739oeo.77.1380289728699; Fri,
 27 Sep 2013 06:48:48 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Fri, 27 Sep 2013 06:48:18 -0700 (PDT)
In-Reply-To: <524547E8.4070406@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235460>

On Fri, Sep 27, 2013 at 3:55 PM, Stefan N=C3=A4we
<stefan.naewe@atlas-elektronik.com> wrote:
>>     [remote "exp"]
>>             url =3D [localhost:2223]:blink.git
>>             fetch =3D +refs/heads/*:refs/remotes/exp/*
>>
>> However, now I get this message:
>>
>>     $ git fetch exp
>>     fatal: ':blink.git' does not appear to be a git repository
>>     fatal: Could not read from remote repository.
>
> I wonder why that worked (especially the "[...]") at all ?
> I thought specifying a port for a SSH connection was always only
> possible when using
>
>        ssh://user@host:port/path/to/repo.git
> - or -
>        ssh://user@host:port/~user/path/to/repo.git
>
> At least that's what I always read out of the git-clone man page.

[] is used to wrap ipv6 and because we don't know if it's actually
ipv6 or v4, we accept it in both cases, so [abc] can be used in place
"host" above. No [host:port]:path won't work because "host:port" is
considered host name. But [host or ip]:path may work (that is after I
fix my bug).
--=20
Duy
