From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 17:37:09 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060227163709.GA12538@informatik.uni-freiburg.de>
References: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org> <20060226103604.2d97696c.akpm@osdl.org> <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org> <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer> <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de> <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com> <4402E56D.4010606@op5.se> <20060227133124.GA8794@informatik.uni-freiburg.de> <4403086F.5040704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 17:37:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDlN7-0004XI-R6
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWB0QhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWB0QhO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:37:14 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:12532 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751478AbWB0QhM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 11:37:12 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FDlN1-0004pf-0K; Mon, 27 Feb 2006 17:37:11 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k1RGb9bW012639;
	Mon, 27 Feb 2006 17:37:09 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k1RGb9Ha012638;
	Mon, 27 Feb 2006 17:37:09 +0100 (MET)
To: Andreas Ericsson <ae@op5.se>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4403086F.5040704@op5.se>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16860>

Andreas Ericsson wrote:
> Uwe Zeisberger wrote:
> >Hello,
> >
> >Andreas Ericsson wrote:
> >
> >>I think the question is whether completely empty lines are also ignored 
> >>by Python, or if they start a new block of code. Whatever the case, it 
> >>must hold true for both 2.3 and 2.4.
> >
> >see
> >	http://www.python.org/doc/2.2.3/ref/blank-lines.html
> >	http://www.python.org/doc/2.3.5/ref/blank-lines.html
> >	http://www.python.org/doc/2.4.2/ref/blank-lines.html
> >
> 
> So in essence, a multi-line statement is closed when a completely empty 
> line is found,
Wrong.

A logical line that contains only spaces, tabs, formfeeds and possibly a
comment, is ignored (i.e., no NEWLINE token is generated). During
interactive input of statements, handling of a blank line may differ
depending on the implementation of the read-eval-print loop. In the
standard implementation, an entirely blank logical line (i.e. one
containing not even whitespace or a comment) terminates a multi-line
statement.

To translate that to python:

  if not interactive:
    a line only containing whitespace is ignored.
  else:
    if standard implementation:
      empty line terminates multi-line statement
    else:
      dependent on implementation

i.e. In scripts, lines containing only (zero or more) whitespaces are
ignored.

hth
Uwe

-- 
Uwe Zeisberger

Set the I_WANT_A_BROKEN_PS environment variable to force BSD syntax ...
	-- manpage of procps
