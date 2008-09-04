From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 4 Sep 2008 16:09:02 +0200
Message-ID: <20080904140902.GY10544@machine.or.cz>
References: <g9o0ac$qig$1@ger.gmane.org> <7v4p4w75b7.fsf@gitster.siamese.dyndns.org> <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 16:10:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbFXL-0000O0-M5
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 16:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbYIDOJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 10:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbYIDOJH
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 10:09:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38667 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYIDOJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 10:09:06 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7BC8A393A2E4; Thu,  4 Sep 2008 16:09:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94936>

On Thu, Sep 04, 2008 at 01:31:19AM -0700, Junio C Hamano wrote:
> To handle --author=<match> request, the code created a grep instruction
> that tried to match a line that begins with 'author ' and <match>
> somewhere on the same line.  "begins with 'author '" obviously needs to be
> expressed with an regexp '^author '.
> 
> When the user specifies --fixed-string, this does not work at all.
> 
> This extends the grep machinery so that a match insn can ignore user
> specified --fixed-string request, and uses the '( -e A --and -e B )'
> construct from the grep machinery in order to express "has to begin with
> '^author ', and also the same line must match the given pattern".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Wow, this is clever solution! FWIW,

Acked-by: Petr Baudis <pasky@suse.cz>

There goes one of my long-standing TODO items. :-)
