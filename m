From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Make linking to actions requiring JavaScript a feature
Date: Fri, 27 Nov 2009 16:41:39 +0100
Message-ID: <200911271641.40947.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911262224.36371.jnareb@gmail.com> <7vy6lsy9mi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 16:41:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE2wP-0000CJ-Hj
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbZK0Pkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbZK0Pkm
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:40:42 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:4933 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbZK0Pkm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 10:40:42 -0500
Received: by fg-out-1718.google.com with SMTP id 19so227474fgg.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8xmBksUqo8a99pmAHXNcBJkUftMVXkXXoDC0UPF91Ho=;
        b=dyUpBrr85V9EYZ6xbGapIUiL+3tgO597dEAwKNYVj7qweRGCee8IVQuy/dI0Jg314M
         9F9+cxx1EN9i8eRqSF3nEj65ZWc6JcrQM3b0m0YeLYd5WaCN3qpg8ihQmzi0XT8oyvVH
         dVEVjC34YfqKarMV42K0bI0fFWe+TeLEqBnTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WjWMCVPW/D+gni751HlXJ/GjUm9ToCW3zEL9ymtCvevacE++b7h4NDaJfb0oBRyc0O
         uSX7kZTY+3Lby7hCC85qPS8a+itmp1TlNHLvc1vrY1cUb5sT3KJ+rs5FBdYUxwuGWTbm
         0ikC/4JNyRovgv9xmfdJTaJfBC0jOOvt0lZrE=
Received: by 10.103.126.32 with SMTP id d32mr414622mun.0.1259336446872;
        Fri, 27 Nov 2009 07:40:46 -0800 (PST)
Received: from ?192.168.1.13? (abwo34.neoplus.adsl.tpnet.pl [83.8.238.34])
        by mx.google.com with ESMTPS id y6sm4707356mug.1.2009.11.27.07.40.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 07:40:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy6lsy9mi.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133902>

On Fri, 27 Nov 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > It might be however good *interim* solution, so people would be able
> > to test 'blame_incremental' view without having to edit gitweb links.
> 
> Exactly.  I thought you were responding to my earlier "ship it as a new
> feature with known breakage so that people can choose to enable to help
> debugging and fixing".  If flipping on the new implementation makes an
> alternative working implementation unavailable, that would be one reason
> the site owners might consider _not_ enabling it.  By making them both
> available, the result will have one less reason not to try for site
> owners.

Actually "addLinks" would be a bit harder, I guess, than current "fixLinks"
because "fixLinks" just adds ';js=1' to URL to denote that gitweb can use
JavaScript-requiring actions equivalents.  For "addLinks" selecting where
to add links would have to be in gitweb.js

I can "borrow" some code from Martin Koegler patch from April 2007
"[PATCH 5/7] gitweb: Prototyp for selecting diffs in JavaScript"
Message-Id: <1176669971921-git-send-email-mkoegler@auto.tuwien.ac.at>
$gmane/44517/focus=44523.  

Would turning

  "blame"

link ito pair of links

  "blame (incremental)"

be a good solution?  I'm trying to come up with good naming for extra link
to 'blame_incremental' action...

-- 
Jakub Narebski
Poland
