From: John Keeping <john@keeping.me.uk>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 19:19:44 +0100
Message-ID: <20150520181944.GA1537@serenity.lan>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
 <vpq382rkvzf.fsf@anie.imag.fr>
 <d21002e0fa92b03c3d417c8996328563@www.dscho.org>
 <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:28:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv8j6-0004xD-NX
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 20:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbbETS2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 14:28:16 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:41450 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbETS2P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 14:28:15 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2015 14:28:15 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9868922EB5;
	Wed, 20 May 2015 19:19:59 +0100 (BST)
X-Quarantine-ID: <7CikZA5QTVCl>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7CikZA5QTVCl; Wed, 20 May 2015 19:19:58 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id CF4432004E;
	Wed, 20 May 2015 19:19:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269489>

On Wed, May 20, 2015 at 11:02:14AM -0700, Stefan Beller wrote:
> $ git clone https://github.com/fmitha/SICL
> cd SICL
> $ git show 280c12ab49223c64c6f914944287a7d049cf4dd0
> fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
> $ git show 12323213123 # just to be sure to have a different error
> message for non existing objects.
> fatal: ambiguous argument '12323213123': unknown revision or path not
> in the working tree.

I think 40 hex characters is special cased.  Using CGit as a repository
with a submodule so I can easily get an unrelated SHA1 and short name:

cgit $ git show $(git -C git rev-parse @)
fatal: bad object bb8577532add843833ebf8b5324f94f84cb71ca0
cgit $ git show $(git -C git rev-parse --short @)
fatal: ambiguous argument 'bb85775': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
