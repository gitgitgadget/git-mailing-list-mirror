From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 12:47:16 -0500
Message-ID: <20100714174716.GB2866@burratino>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100714153206.GH25630@jack.stsp.name>
 <20100714160149.GA7561@debian>
 <20100714172429.GC25861@ted.stsp.name>
 <4C3DF456.20803@collab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "C. Michael Pilato" <cmpilato@collab.net>
X-From: git-owner@vger.kernel.org Wed Jul 14 19:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ647-0006HX-Nc
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821Ab0GNRsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:48:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47813 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab0GNRsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:48:08 -0400
Received: by ewy23 with SMTP id 23so4481ewy.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dxFGkFIqVIXNxVxwj8qfUDNSNQJwLsNR4fpCpGa18YE=;
        b=qBb9QnLDVyBCtES81Ygyh1kA9HGfj/YsBh85nQCR0ilCez8JDhNBHk/wLwr4p7bkgj
         p6PvCrRsooAYJyCtBzuI0+CYvzULX1XMqJkdCksmeOJBJsSZ0i7y6KjFl8vEBQp4Mser
         v2bzrBBmPpTkID7Yuy16QmcObTnsgajRMDHnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KKSIBFS+m/rxjwB21aZz4yOTuo3UtrHrjjyKZ3wn5gimJKvSCyykV8JP+65/N6NZVm
         rvVmlmMR7HwxK1dyialEltNepPac1QfY2jGFfELvtNL5UyAvql8gM1c+Xi5DXpjuCR2t
         xXwmufRmkP7sKoZrZzERJcjfPTJnOhdV1Fz44=
Received: by 10.213.22.18 with SMTP id l18mr3455022ebb.85.1279129686164;
        Wed, 14 Jul 2010 10:48:06 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v8sm33130eeh.14.2010.07.14.10.48.03
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 10:48:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C3DF456.20803@collab.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151022>

C. Michael Pilato wrote:

> Revprops aren't handled by the replay API for any revision.

Hmm?  What is the rev_props argument to the

typedef svn_error_t (*svn_ra_replay_revstart_callback_t)(
				svn_revnum_t revision,
				void *replay_baton,
				const svn_delta_editor_t **editor,
				void **edit_baton,
				apr_hash_t *rev_props,
				apr_pool_t *pool)

callback for, then?

Using svn_ra_rev_prop() for rev 0 does seem simple enough, though.
