From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/4] Implement a new patch identification scheme and id command
Date: Mon, 14 Jul 2008 08:58:14 +0200
Message-ID: <20080714065814.GF20751@diana.vm.bytemark.co.uk>
References: <20080713113853.18845.37686.stgit@localhost.localdomain> <20080713114035.18845.45056.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KII1n-0007UU-Aq
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYGNG6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 02:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbYGNG6V
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:58:21 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2213 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbYGNG6U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:58:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KII0k-0005ob-00; Mon, 14 Jul 2008 07:58:14 +0100
Content-Disposition: inline
In-Reply-To: <20080713114035.18845.45056.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88389>

On 2008-07-13 12:40:35 +0100, Catalin Marinas wrote:

> The new scheme allows '[<branch>:]<patch>' and '[<branch>:]{base}'
> (the latter showing the base of a stack). The former format allows
> symbols like ^ and ^{...}.

You changed it, so s/The former format allows/You may append/ or
something.

> +    # The stack base
> +    if patch.startswith('{base}'):
> +        base_id =3D repository.get_stack(branch).base.sha1
> +        return repository.rev_parse(base_id + patch[6:])

We have a strip_prefix() function precisely so that we can avoid
error-prone and not-so-easy-to-read constants like that "6" ...

Hmm. I see that I feel strongly enough about this that I've defined no
less than two identical functions in utils.py to do this job:
strip_prefix() and strip_leading(). :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
