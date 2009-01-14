From: Todd Zullinger <tmz@pobox.com>
Subject: Re: .ft tag in man
Date: Wed, 14 Jan 2009 01:45:10 -0500
Message-ID: <20090114064510.GZ18365@inocybe.teonanacatl.org>
References: <20090114052126.GA6849@b2j>
 <7veiz678m2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="72btQdUC6twB1rwh"
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 07:46:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMzWW-0004mO-FZ
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 07:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbZANGpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 01:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbZANGpS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 01:45:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbZANGpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 01:45:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5FBD790738;
	Wed, 14 Jan 2009 01:45:14 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [68.83.124.46]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BC89F90737; Wed,
 14 Jan 2009 01:45:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7veiz678m2.fsf@gitster.siamese.dyndns.org>
X-Listening-To: Nothing
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: E5C8A8B8-E206-11DD-89BA-5720C92D7133-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105589>


--72btQdUC6twB1rwh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> bill lam <cbill.lam@gmail.com> writes:
>
>> The diagram in man contain some .ft tag, eg inside
>> PAGE=3Dless git help rebase
>> it contains
>>
>>            .ft C
>>                      A---B---C topic
>>                     /
>>                D---E---F---G master
>>            .ft
>
> No, I do not see that neither on my Debian nor on k.org's FC 9.

I began seeing this on Fedora 10.  Defining DOCBOOK_XSL_172 fixed
that issue, but seems to have caused another. :/

For example, in git-diff.1, without DOCBOOK_XSL_172, I see:

               .ft C
               $ git diff            (1)
               $ git diff --cached   (2)
               $ git diff HEAD       (3)
               .ft

With DOCBOOK_XSL_172, I get this:

               $ git diff            =E2=96=93fB(3)=E2=96=93fR
               $ git diff --cached   =E2=96=93fB(2)=E2=96=93fR
               $ git diff HEAD       =E2=96=93fB(3)=E2=96=93fR

The '.ft' problem is gone, but '\fB' and '\fR' are replaced by '=E2=96=93fB'
and '=E2=96=93fR', respectively.  The paragraphs that follow such a list of
commands show more ugliness:

           =E2=8C=82sp =E2=96=93fB1. =E2=96=93fRChanges in the working tree=
 not yet staged for the
           next commit.  =E2=8C=82br =E2=96=93fB2. =E2=96=93fRChanges betwe=
en the index and your
           last commit; what you would be committing if you run "git commit"
           without "-a" option.  =E2=8C=82br =E2=96=93fB3. =E2=96=93fRChang=
es in the working tree
           since your last commit; what you would be committing if you run
           "git commit -a" =E2=8C=82br

Defining ASCIIDOC8 seems to have no effect on this problem.

> Perhaps you are using different version of asciidoc/docbook/xmlto
> toolchain?

On Fedora 10, these are the versions:

asciidoc-8.2.5-2.fc9
docbook-dtds-1.0-41.fc10
docbook-style-xsl-1.74.0-4.fc10
xmlto-0.0.21-2.fc10

Fedora 9 has:

asciidoc-8.2.5-2.fc9
docbook-dtds-1.0-38.fc9
docbook-style-xsl-1.73.2-10.fc9
xmlto-0.0.20-3.fc9

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Once ... in the wilds of Afghanistan, I lost my corkscrew, and we were
forced to live on nothing but food and water for days.
    -- W.C. Fields


--72btQdUC6twB1rwh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAABAgAtBQJJbYnwJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjL1MH/1CGXW5zD+7mcvWE/tf35UHfMOfByyHr5t5h
yUePY3RjpnJ5iXw/fD4gM3lsuX0ZfiWGUQqRS4Srtf4zWF7NsrF/ftfK9ijM3IPg
vOy3/tKd/v+BeS2gOceGf6dW3auZld9LMddVMUiIYytgAtEkB6NL5OdwFRJC7gdq
p5yIeAORBPjTqIRi6FpsGyCZ3TQSwtU8U2iw2bJ6Wdz2QirahH6Hs88hnjNRmwHh
yBWz3ks6emRODEwxEoAvdGHOXQv6RCh+AF+RmX0dCFsbZvnJn18hG1oU1NsRsDkv
+a4JmGJkFTaDXvga/ClP0FiySi5E4tm5+SPK5XJbVO2i/qDLHI4=
=HOOM
-----END PGP SIGNATURE-----

--72btQdUC6twB1rwh--
