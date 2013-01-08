From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Tue, 08 Jan 2013 19:28:40 +0100
Message-ID: <50EC6558.6080608@gmail.com>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se> <7vobh4sffw.fsf@alter.siamese.dyndns.org> <7vehi0qh4x.fsf@alter.siamese.dyndns.org> <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se> <50EC5D41.6030209@gmail.com> <20130108180518.GO6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Khouzam <marc.khouzam@ericsson.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jan 08 19:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsdvX-0005AI-2P
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 19:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab3AHS3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 13:29:10 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46688 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab3AHS3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 13:29:09 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so749465wgb.1
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=pAO3MictO/ay5EZCt3vxgaWrwCYqVgxRWqwMgAOFlyU=;
        b=aQgPxHFNl/E8sLykXKNcPAj4AuMksV3Jyw7nRapTZLjYXkRUnSrrcd6FIxDJBMZg4y
         fP+fQziYKcf782DrKXHTMdF6jEXG/2kcO0yL0qhD8qRZtDZ9+/IMuYBVbEjefkn4BZbU
         GqaFWz47ISGqtQp4iKW9IPbhVLuv1GubEaRBWF0y01ifgYsOEfd5NeLIkBhbh5tLhBxQ
         iVzp8JsCf/G5X6uebnuDJSV6vvpG8foX8UoBezko34T2BHOypQl4nYVHGIbh27tfXaRc
         /ehILyEyIkdfa1BmiHzUxMkpIiCj3/EYH/pBNezbsOmDxah+pvJU03NzUJawZ0YI3YOq
         Walw==
X-Received: by 10.194.172.228 with SMTP id bf4mr11635579wjc.38.1357669747513;
        Tue, 08 Jan 2013 10:29:07 -0800 (PST)
Received: from [192.168.0.3] ([151.70.216.223])
        by mx.google.com with ESMTPS id i2sm202472wiw.3.2013.01.08.10.29.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 08 Jan 2013 10:29:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <20130108180518.GO6440@serenity.lan>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212990>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 08/01/2013 19:05, John Keeping ha scritto:
> [...]
>>
>> After some searching, I found how this is supposed to be done.
>> It is possible to use the -o filenames option to tell Bash completion
>> that "the compspec generates filenames, so it can perform any
>> filename-specific processing".
>>
>> Unfortunately this option must be passed to the complete builtin
>> command, and we can not do this, since the comspec not always contains
>> filenames.
> 
> You should also be able to pass it to 'compopt' during completion in
> order to change the behaviour for only the current completion.
> 

Thanks, compopt is what I wanted.

I was reading an old Bash manual (for Bash 3.1), and compopt is only
available starting from Bash 4.0.

I will do some test, being careful to not break the code for Bash < 4.0
and the other supported shells.



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDsZVgACgkQscQJ24LbaUQlAACdGbhOuGICCYFwkRTPJla+3JGT
EcQAoINEGvdwtOz1QFbAA4FqoI3c7VSa
=5Oqw
-----END PGP SIGNATURE-----
