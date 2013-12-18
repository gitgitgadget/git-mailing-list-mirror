From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git add -A fails in empty repository since 1.8.5
Date: Wed, 18 Dec 2013 20:24:35 +0100
Message-ID: <vpqvbymarnw.fsf@anie.imag.fr>
References: <CAEcj5uWHpem+5os+3Mc_a42pk6f30i4UiV=LRPdXkoqiy1jQ_w@mail.gmail.com>
	<CALWbr2wXxSU4qD_Gj5P7aYxB39tEVBa-TDALVepuwZLh+RNU1Q@mail.gmail.com>
	<CACsJy8DY7eZm7-P=azJF-jEiBKM_QPf_GXG3uzbuw5C1vq1Q5A@mail.gmail.com>
	<xmqqioumhtvp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 20:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtMjn-0002YQ-4y
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 20:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3LRTYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 14:24:51 -0500
Received: from mx1.imag.fr ([129.88.30.5]:33493 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3LRTYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 14:24:50 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rBIJOalG018266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Dec 2013 20:24:36 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rBIJOaAs011222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 18 Dec 2013 20:24:38 +0100
In-Reply-To: <xmqqioumhtvp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Dec 2013 10:54:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Dec 2013 20:24:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rBIJOalG018266
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1387999481.37804@cNp7KjS7++5KjPI1rIw3sg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239471>

Junio C Hamano <gitster@pobox.com> writes:

> It could be argued that a "git add [<any option>] .", with an
> explicit "." given by the end-user, that is run in an empty
> directory may be an error worth reporting.

But what we have right now is really weird:

# setup repo with one empty dir:
$ rm -fr test
$ git init test
Initialized empty Git repository in /tmp/test/.git/
$ cd test
$ mkdir foo

$ git add .
fatal: pathspec '.' did not match any files

=> The one we're discussing.

$ git add foo

=> No error when an empty directory other than . is given.

$ cd foo
$ git add .

=> No error either for "git add ." when not at the root of the repo.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
