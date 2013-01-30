From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Wed, 30 Jan 2013 20:58:01 +0100
Message-ID: <51097B49.6070301@gmail.com>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com> <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com> <5106A5CE.3000800@drmicha.warpmail.net> <7vd2wpxki1.fsf@alter.siamese.dyndns.org> <5106DC87.7090607@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC097A7E@eusaamb103.ericsson.se> <51096543.9050100@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC097E39@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Michael J Gruber' <git@drmicha.warpmail.net>,
	'wookietreiber' <kizkizzbangbang@googlemail.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:00:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dpV-0008CW-Lm
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782Ab3A3T76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:59:58 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:56488 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab3A3T75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:59:57 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so1091329eek.28
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=ieOEzT12tNeR/oAomkXIWfBnLAvin46ZDFhS4X4NMhI=;
        b=HcMQR4uL5rsH8QrQoUGhrz4Wk950z6ymG1OKQnCa99juWPdXvtZMexbYgA8ONHtyKT
         voEOv9sdxvE6gEpx8qmKhvbLo3pyl/P0KWDh6hxxCRvMAIQcmKrm5WDX27qpzD7tv/pT
         c1G7zO0wFiqHzQYkurfWwjL75bgzZjwybKTCz7caIY7ayaS7egwppWIbLAMdFPC9cDHg
         mpkvQtdsHjXMoOg8pgi8y13Z++lHRLn+3pbtWgztSVdjfEVnYdd8Um4lrOZkQO0yPftg
         6d2p7oMx0F+NxoD7I8w5K2qj1YhF41ndwDGR7PFXehKxpJY2gA4qHRc2vN3sJh9MuhXV
         DbOw==
X-Received: by 10.14.174.198 with SMTP id x46mr18221379eel.23.1359575996584;
        Wed, 30 Jan 2013 11:59:56 -0800 (PST)
Received: from [192.168.0.3] ([151.70.202.186])
        by mx.google.com with ESMTPS id f6sm3643333eeo.7.2013.01.30.11.58.51
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 11:59:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC097E39@eusaamb103.ericsson.se>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215065>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 30/01/2013 19:55, Marc Khouzam ha scritto:
> [...]
>>>> The new logic in git-completion.bash tells bash that 'filenames'
>>>> completion is ongoing so bash will add a '/' after directories.
>>>> Sadly, tcsh won't do that, so it would be simpler if
>>>> git-completion.bash added the '/' itself.  I looked at the 
>>>> git-completion.bash script changes and I noticed that for 
>>>> bash version < 4, you have to add the '/' yourself.
> 
> The compatible version is not only required for Bash; you can 
> use it for
> other shells.
> 
> Try to redefine the __git_index_file_list_filter function to use the
> version that adds a slash to directory names.
> 
>> I hadn't thought of that!
>> Although I would prefer not to have special cases like that,
>> it does work well.

The zsh compatible code does something like this; this is the reason I
tried to do the same thing, in order to keep coding consistent.

> [...]
>
> Bash 4.1.5(1) always adds an additional slash for directories.
> I have tested it right now: change the filter function to use the
> compatible version:
> 
> __git_index_file_list_filter ()
> {
> 	# Default to Bash >= 4.x
> 	__git_index_file_list_filter_compat
> }
> 
> 
> Then running `git add <TAB>` inside the git repository, I get 
> this file
> completion list:
> 
> $ git add <TAB>
> contrib//
> 
>> Ok, I see.  The double-slash is visible in the completion list
>> but it does not appear on the command-line when bash automatically
>> adds it.

Right; that's why I wrote in the comment that Bash behaviour "seems" stupid.
But probably that comment should be remove or changed for the final
version of the patch; I'll leave that to a Bash expert.

> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEJe0kACgkQscQJ24LbaUScGgCeMDDdprJMgnYtFzqnFQamhfvU
BikAniMkwbOEVkkomOd9G0m3KY44f/9O
=c8rC
-----END PGP SIGNATURE-----
