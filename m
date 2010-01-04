From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: RFC: display dirty submodule working directory in git gui and
 gitk
Date: Mon, 04 Jan 2010 18:04:16 +0100
Message-ID: <4B421F90.4090402@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 18:04:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRqM7-0002yG-5B
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 18:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab0ADREY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 12:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601Ab0ADREW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 12:04:22 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:55216 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0ADREU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 12:04:20 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 37F88144275E7;
	Mon,  4 Jan 2010 18:04:19 +0100 (CET)
Received: from [80.128.60.62] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NRqLq-0003kW-00; Mon, 04 Jan 2010 18:04:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18o1Rsclgzik7be+HgCYL/YCDkekBOsKXVpnNjA
	ll9MgQqoqKYZiqPyAe8AfIEFCoPY/SN50DUSoQJhcjI0RAdwMQ
	/K9IqzQGGGfNb+3trHWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136131>

Am 04.01.2010 10:44, schrieb Johannes Schindelin:
> The real problem is that submodules in the current form are not very well 
> designed.

IMVHO using the tree sha1 for a submodule seems to be the 'natural' way
to include another git repo. And it gives the reproducibility i expect
from a scm. Or am i missing something?

It looks to me as most shortcomings come from the fact that most git
commands tend to ignore submodules (and if they don't, like git gui and
gitk do now, they e.g. only show certain aspects of their state).

Submodules are in heavy use in our company since last year. Virtually
every patch i submitted for submodules came from that experience and
scratched an itch i or one of my colleagues had (and the situation did
already improve noticeably by the few things we changed). We are still
convinced that using submodules was the right decision. But some work
has still to be done to be able to use them easily and to get rid of
some pitfalls.


> In ths short run, we can paper over the shortcomings of the submodules by 
> introducing a command line option "--include-submodules" to 
> update-refresh, diff-files and diff-index, though.

Maybe this is the way to go for now (and hopefully we can turn this
option on by default later because we did the right thing ;-).
