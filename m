From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 8 Apr 2012 11:28:56 +0100
Message-ID: <20120408102856.GB22648@river.lan>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 12:29:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGpMl-0004Ti-SK
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 12:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab2DHK27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 06:28:59 -0400
Received: from honeysuckle.london.02.net ([87.194.255.144]:47594 "EHLO
	honeysuckle.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab2DHK26 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 06:28:58 -0400
Received: from river.lan (78.86.105.148) by honeysuckle.london.02.net (8.5.140)
        id 4F58EC1A00D41C78; Sun, 8 Apr 2012 11:28:57 +0100
Content-Disposition: inline
In-Reply-To: <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194988>

On Sun, Apr 08, 2012 at 06:07:48AM +0300, Felipe Contreras wrote:
> +test_completion ()
> +{
> +	local -a COMPREPLY _words
> +	local _cword
> +	_words=( $1 )
> +	test $# -gt 1 && echo "$2" > expected
> +	(( _cword = ${#_words[@]} - 1 ))
> +	_git && print_comp &&
> +	test_cmp expected out
> +}

Could you check that _git doesn't output anything to stderr here?  I
can't see any reason why a completion command should ever do so
legitimately and it's generally annoying if one does.

-- 
John
