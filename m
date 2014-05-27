From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH] t9138-git-svn-authors-prog.sh fixups
Date: Tue, 27 May 2014 12:53:11 -0700
Message-ID: <20140527195311.GA20054@hudson.localdomain>
References: <1401045894-22711-1-git-send-email-jmmahler@gmail.com>
 <xmqq8upnf1o5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 21:53:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNR6-0008O3-Md
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 21:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbaE0TxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 15:53:17 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34478 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbaE0TxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 15:53:15 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so9890575pbc.0
        for <git@vger.kernel.org>; Tue, 27 May 2014 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=42INrvsNvAIiYpzjToCe67NWdg5BaZP44vxQXXBFCzQ=;
        b=BvZaLrkhBGDwOCJ92j9ovhqH2XPQ8Lk6xn4xvuNgzKtsFrIZsbo908LYDEzbjKQztz
         iDtN6fMruEOX084z6fHrw8m577wb/KgtHmfNFobV6TmQcghFaHH/QImBvP4zWINrc8+u
         gV5/jEGd+cX/Ipo48OKxg/GWgPyVby+9iFyRG117lmo0B/mteiaEkxHLQe8oUi5/oAWN
         9FzZIf27BdiitoVf/eTTsOyofNt8dm4Kq++SZRHgvMll+FhHFwa/De24R6iZ363BhjZS
         1ONIHZVE2WEBF9WPEaVcqH5fkZYU9u99OW3nd7jmdmIB6bU8mcKs+FrKtP4x2upzVB8B
         wwxQ==
X-Received: by 10.66.241.66 with SMTP id wg2mr39154635pac.132.1401220395404;
        Tue, 27 May 2014 12:53:15 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ky8sm24658371pbc.64.2014.05.27.12.53.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 May 2014 12:53:14 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 27 May 2014 12:53:11 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqq8upnf1o5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250196>

Junio,

On Tue, May 27, 2014 at 12:43:06PM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
...
> > diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
> > index 83cc5fc..d54c37a 100755
> > --- a/t/t9138-git-svn-authors-prog.sh
> > +++ b/t/t9138-git-svn-authors-prog.sh
> > @@ -7,40 +7,39 @@ test_description='git svn authors prog tests'
> >  
> >  . ./lib-git-svn.sh
> >  
> > -cat > svn-authors-prog <<'EOF'
> > -#!/usr/bin/perl
> > -$_ = shift;
> > -if (s/-sub$//)  {
> > -	print "$_ <$_\@sub.example.com>\n";
> > -}
> > -else {
> > -	print "$_ <$_\@example.com>\n";
> > -}
> > +write_script svn-authors-prog $PERL_PATH <<-\EOF
> 
> I think you meant to dq "$PERL_PATH" here.  Other than that, looks
> OK to me.
> 
> Thanks.

Ah, you're right, it needs the quotes.  Can this minor changed be fixed
by editing the patch or should I re-send it?

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
