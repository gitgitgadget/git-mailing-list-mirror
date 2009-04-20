From: Teemu Likonen <tlikonen@iki.fi>
Subject: "git config --edit" outside a Git repository
Date: Mon, 20 Apr 2009 19:29:34 +0300
Message-ID: <87fxg3ffv5.fsf@iki.fi>
References: <7v1vrptpn3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 18:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvwOr-0008N9-P3
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 18:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbZDTQ3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 12:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbZDTQ3o
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 12:29:44 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:45935 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbZDTQ3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 12:29:43 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 49CA1E67011459DC; Mon, 20 Apr 2009 19:29:40 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LvwNC-0001bM-9L; Mon, 20 Apr 2009 19:29:34 +0300
In-Reply-To: <7v1vrptpn3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 18 Apr 2009 18\:10\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117007>

On 2009-04-18 18:10 (-0700), Junio C Hamano wrote:

> * git-config learned -e option to open an editor to edit the config
>   file directly.

There's a small flaw in this feature when "git config --edit" is run
outside a Git repository. It launches $EDITOR but complains on saving
that the file does not exist (tried with emacsclient and vim). I think
it should check before if there's a repository around. "git config
--global --edit" works.

Otherwise this is a nice feature. :-)
