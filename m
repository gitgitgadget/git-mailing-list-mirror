From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Sun, 06 Jan 2013 19:00:21 +0100
Message-ID: <50E9BBB5.3000707@gmail.com>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se> <7vobh4sffw.fsf@alter.siamese.dyndns.org> <7vehi0qh4x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Khouzam <marc.khouzam@ericsson.com>, git@vger.kernel.org,
	szeder@ira.uka.de, felipe.contreras@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 19:00:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TruWo-00078T-CT
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 19:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab3AFSAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 13:00:39 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:52866 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069Ab3AFSAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 13:00:38 -0500
Received: by mail-we0-f175.google.com with SMTP id z53so9396254wey.34
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 10:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=FbON0NATA3ehx9nMjqxLgO22Nq7GO82qNPy18oQHdGw=;
        b=ebCyVv3l8SO6l3QFiprQYLjXCaSSByI1AbsTbekVCcYK2rlUOVWKk+ogRYgXjEdWb2
         PX0SZOtPxNUQNrDkPgMdhkbSqRTKfspQyRjLU/qMwacl07kjh6348nZrI5JkXlL/rrPj
         1kqvapZGwlY3IgB+mZZP3MjPZsb+fmAIvo1nTfJICNYbQfBqznyItH0LoT2w5eHcNeFT
         vJ4CrtomM6EBNttKicT1Um2z86RnTMaxnlLWqr/9XxsUxJUk2VQzd2tMw0yElQH/cZoR
         vn16/bGViq+O47sEvHrWde0tBXUtBQ5WBg/wup9FdxbK6xBAM6u2xyfeC6E8Ld7ghkGS
         zJIg==
X-Received: by 10.194.78.207 with SMTP id d15mr92099232wjx.52.1357495236773;
        Sun, 06 Jan 2013 10:00:36 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id fv2sm8503738wib.4.2013.01.06.10.00.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 06 Jan 2013 10:00:35 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vehi0qh4x.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212831>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 05/01/2013 07:27, Junio C Hamano ha scritto:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Marc Khouzam <marc.khouzam@ericsson.com> writes:
>>
>>> I've been playing with it but I'm not getting the expected 
>>> behavior when I cd to a sub-directory.
>>
>> Thanks for testing.  Manlio?
> 
> Can you try the attached patch?
> 

Thanks, it seems to fix the problem.

> As I am not familiar with the completion machinery, take this with a
> large grain of salt.  Here is my explanation of what is going on in
> this "how about this" fixup:
> 
>  * Giving --git-dir from the command line (or GIT_DIR environment)
>    without specifying GIT_WORK_TREE is to signal Git that you are at
>    the top of the working tree.  "git ls-files" will then show the
>    full tree even outside the real $cwd because you are lying to
>    Git.
> 

I was not aware of this, and blindly copied the code from the other
existing functions.
However the other completion functions never have to deal with paths in
the working directory.


I have applied the patch to my local branch.


> [...]


Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDpu7UACgkQscQJ24LbaUSmUACgl+OKUyvpp183kFZGmBpOfqm1
yqEAnjxcqmZYvWSeIpOo6cNFl/dnMH76
=oE/+
-----END PGP SIGNATURE-----
