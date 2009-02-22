From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Blamming a diff between two commits?
Date: Sun, 22 Feb 2009 13:32:48 +0100
Message-ID: <20090222123248.GA6504@efreet.light.src>
References: <499AB8A1.7090909@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Sun Feb 22 13:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbDXJ-0000Vt-Qe
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 13:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZBVMcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbZBVMcx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 07:32:53 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:57227 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbZBVMcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 07:32:52 -0500
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by mail.bluetone.cz (Spam Firewall) with ESMTP
	id 4D67631F389; Sun, 22 Feb 2009 13:32:49 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by mail.bluetone.cz with ESMTP id AR9G4CuMhuPF1fSf; Sun, 22 Feb 2009 13:32:49 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1LbDVp-0003ny-1U; Sun, 22 Feb 2009 13:32:49 +0100
Content-Disposition: inline
In-Reply-To: <499AB8A1.7090909@datacom.ind.br>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111002>

On Tue, Feb 17, 2009 at 10:16:17 -0300, Samuel Lucas Vaz de Mello wrote:
> Hi,
> 
> Is there any way to git blame (or annotate) a diff between two commits?
> 
> I'm looking for something that produce something like this:
> 
>                               /**
> 85a02065 (samuel 2009-01-02) - * \brief      Define a participacao da porta estatica/dinamica
> 85a02065 (samuel 2009-01-02) - * \param      unit            indice da unidade
> e106303a (arthur 2009-01-17) - * \param	     extraparam      extra parameter
> 85a02065 (samuel 2009-01-02) - * \param      port            indice da porta
> 50e22e7d (fabian 2009-01-09) - * \param      deleted         param to be deleted
> 85a02065 (samuel 2009-01-02) + * \brief      Sets port membership on a static / dynamic 
> 85a02065 (samuel 2009-01-02) + * \param      unit            unit index
> 85a02065 (samuel 2009-01-02) + * \param      port            port index
> e106303a (arthur 2009-01-17) + * \param	     another         another index
>                                * \return     0 if Ok; -1 in error
>                                */
> 
> This would be useful for code reviews. I can use a diff containing all changes committed to a branch, for example, in the last 10 days to review. Doing this instead of reviewing individual commit patches save us from waste time analyzing code that has already been changed/fixed. 
> 
> Using a git-blame in the resulting file give me the commits for the lines added, but not for the deleted ones.
> 
> Any suggestion on how to do this?

What about doing a diff of the blames? It should do the same thing (except
the +/- would be at the begining of the lines). Well, not exactly, because if
there was a change, that was reverted again, blames would change, so it would
appear here, but that's probably rare enough to ignore (if you don't even
want to see it rather than not).

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
