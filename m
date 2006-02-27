From: "Adrien Beau" <adrienbeau@gmail.com>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 17:22:59 +0100
Message-ID: <94fc236b0602270822v1922b15dw9f7c09351210e08f@mail.gmail.com>
References: <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	 <20060226103604.2d97696c.akpm@osdl.org>
	 <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	 <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	 <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
	 <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
	 <4402E56D.4010606@op5.se>
	 <20060227133124.GA8794@informatik.uni-freiburg.de>
	 <4403086F.5040704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Uwe Zeisberger" <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 17:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDl9P-0008Uh-9l
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWB0QXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWB0QXE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:23:04 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:14127 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751450AbWB0QXD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 11:23:03 -0500
Received: by zproxy.gmail.com with SMTP id x7so932500nzc
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 08:23:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=utGVgQehyPF+jrcyzqjqNX71tbmd09auuw3/HD9LuQoLo71Ms90tRGco94GuAUc4E0dD+8ImcYfDWlVDfPNVMVgJopEaEj0WXD5mRwCD4ymSVC9YHfqYWyBg2yuGL6XkwGerewvMhmJZ9yesdPJg8WAgpCi3/VIH+b5j5duQK/o=
Received: by 10.37.2.49 with SMTP id e49mr5626775nzi;
        Mon, 27 Feb 2006 08:22:59 -0800 (PST)
Received: by 10.36.250.33 with HTTP; Mon, 27 Feb 2006 08:22:59 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <4403086F.5040704@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16858>

On 2/27/06, Andreas Ericsson <ae@op5.se> wrote:
>
> So in essence, a multi-line statement is closed when a completely empty
> line is found, which means that making git internals recognize and strip
> such lines will result in Python code never being manageable by git.

Incorrect. This is only the case in the *interactive* interpreter in
the standard implementation. For source code in general, quoting the
Python Reference Manual:

"A logical line that contains only spaces, tabs, formfeeds and
possibly a comment, is ignored (i.e., no NEWLINE token is generated)."

So such lines, whether completely empty or only apparently so (i.e.
dirty), are ignored, and can be safely cleaned-up.

Adrien
