From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: RE: git-completion.tcsh and git-completion.zsh are broken?
Date: Wed, 9 Jan 2013 20:21:41 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC06B99D@eusaamb103.ericsson.se>
References: <50EDC237.3000309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'Manlio Perillo'" <manlio.perillo@gmail.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:22:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt2A1-0001WW-HO
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 21:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab3AIUVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 15:21:45 -0500
Received: from imr4.ericy.com ([198.24.6.9]:51043 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106Ab3AIUVn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 15:21:43 -0500
Received: from EUSAAHC002.ericsson.se ([147.117.188.78])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r09KaQEr019650;
	Wed, 9 Jan 2013 14:36:27 -0600
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC002.ericsson.se ([147.117.188.78]) with mapi id 14.02.0318.004; Wed, 9
 Jan 2013 15:21:42 -0500
Thread-Topic: git-completion.tcsh and git-completion.zsh are broken?
Thread-Index: AQHN7p4DKm7zhAd3LEmSf2cUlm1vl5hBbfog
In-Reply-To: <50EDC237.3000309@gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213098>


> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Manlio Perillo
> Sent: Wednesday, January 09, 2013 2:17 PM
> To: git@vger.kernel.org
> Subject: git-completion.tcsh and git-completion.zsh are broken?
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi.
> 
> I have finally resolved all the problems with my path completion in
> git-completion.bash and, in order to avoid regressions, I'm 
> checking the
> git-completion.zsh and git-completion.tcsh scripts, since they use the
> bash completion support.
> 
> I have installed (Debian 6.0.6):
> * zsh 4.3.10 (i686-pc-linux-gnu)
> * tcsh 6.17.02 (Astron) 2010-05-12 (i586-intel-linux)
>   options wide,nls,dl,al,kan,rh,nd,color,filec
> 
> Note that I'm using my modified git-completion.bash script.
> 
> 
> zsh compatibility support in git-completion.bash seems to 
> "work" (I just
> get a segmentation fault ...), however I have problems with 
> the .zsh and
> .tcsh scripts.
> 
> 
> $zsh
> synapsis% source contrib/completion/git-completion.zsh
> (anon):6: command not found: ___main
> _git:11: command not found: _default
> 
> I have disabled compinit autoload (since, I don't know how, it is able
> to find the git completion script)
> 
> 
> $tcsh
> synapsis:~/projects/git/contrib/git> source ~/.git-completion.tcsh
> synapsis:~/projects/git/contrib/git> git show HEAD:<TAB>
> 
> does not show the file list for the tree object in the HEAD

Hm.  That doesn't work for me either.  I'll look into it.
It is not caused by your changes.

> another problem is that a space is added after a directory name.

The lastest version of git-completion.tcsh in the pu branch should
fix that problem.  It was committed yesterday so you may not have it.

> 
> 
> Another problem with zsh:
> 
> $zsh
> synapsis% git show HEAD:<TAB>569GPXZims
> 
> I don't know where that 569GPXZims came from.
> 
> 
> Can someone else confirm these problems?
> 
> 
> Thanks  Manlio
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAlDtwjcACgkQscQJ24LbaURpuACfVQnoBC3tzvxB0JYxQ5aL3rmN
> 8GEAnA7OjVtPqz+aq/PGtNtTHWgFqhKK
> =3UdZ
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 