From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] Handle path completion and colon for tcsh script
Date: Sun, 03 Feb 2013 20:59:32 +0100
Message-ID: <510EC1A4.4000207@gmail.com>
References: <E59706EF8DB1D147B15BECA3322E4BDC09AA38@eusaamb103.ericsson.se> <7vboc2bhpj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Khouzam <marc.khouzam@ericsson.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 21:00:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U25jo-0001yU-0t
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 21:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab3BCUAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 15:00:06 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:41792 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab3BCUAE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 15:00:04 -0500
Received: by mail-bk0-f41.google.com with SMTP id q16so2526117bkw.0
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 12:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=9WOwHW8eoMUqm0pvc9Z4+KCNF5d99fURMCOHy7gVRwk=;
        b=EVXnuB9BLk6Wz+n6p2nbMASH2dfHtXpkPG9/zqLK4aCjfBDPGEFPa14A/IfPML3LY3
         cATJG+/Q2ddWZDCg9FSAbXTspKgfuZ8F4fPF0Nc8r+PhL9WDr//5vcpELhi3Y5gm/y89
         TRIFyQ66U+tiFdAEYu6N7qwj45DUNEmTRQHteGDjq56geS+t421GjdPzYkKuihfJ4PME
         wl8ZutgSpI0n/r9t9VNlAjoOf+PTxDRjrtcKk8vwxhXbmlCobp/PL4e9D/1MogllTOS+
         ZqOj1Cu9U4ASxRKk4GMn7Fk6M9b/Qi3/sWW7emDhv3uNr4dOnsCXLvwTBdOPIo9qgCuC
         afEA==
X-Received: by 10.204.150.199 with SMTP id z7mr4858309bkv.139.1359921602463;
        Sun, 03 Feb 2013 12:00:02 -0800 (PST)
Received: from [192.168.0.3] ([151.70.210.59])
        by mx.google.com with ESMTPS id b21sm3449465bkw.12.2013.02.03.11.59.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 12:00:01 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vboc2bhpj.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215329>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 02/02/2013 21:10, Junio C Hamano ha scritto:
> Marc Khouzam <marc.khouzam@ericsson.com> writes:
> 
>> Recent enhancements to git-completion.bash provide
>> intelligent path completion for git commands.  Such
>> completions do not add the '/' at the end of directories
>> for recent versions of bash.
>> ...
>> Here is the update for tcsh completion which is needed to handle
>> the cool new path completion feature just pushed to 'next'.
>>
> [...]
> But I have to wonder if this is sweeping a problem under the rug.
> Shouldn't the completion for bash users end completed directory name
> with '/', even if we didn't have to worry about tcsh?
> 

The problem is that when using the "new"
`compopt -o filenames` command, Bash assumes COMPREPLY contains a list
of filenames, and when it detects a directory name, it adds a slash.

The problem is, if the directory name *already* has a slash, Bash adds
another slash!

I don't know if this can be considered a bug or a feature.


Regards  Manlio

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEOwaQACgkQscQJ24LbaUSjwgCfbgb1id5DcNG0Q75FWwgNPCqb
qkUAnAmMzCahB745/BWeDJTHbJFXucxs
=vf+P
-----END PGP SIGNATURE-----
