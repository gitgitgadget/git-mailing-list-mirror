From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Use "previous" header of git-blame -p in 'blame' view
Date: Sat, 11 Jul 2009 11:17:20 +0200
Message-ID: <200907111117.22206.jnareb@gmail.com>
References: <200907102354.43232.jnareb@gmail.com> <200907102357.43475.jnareb@gmail.com> <7v4otkuqlq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 11:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPYiE-0005AA-SK
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 11:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbZGKJRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 05:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZGKJRf
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 05:17:35 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:63688 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZGKJRe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 05:17:34 -0400
Received: by ewy26 with SMTP id 26so1611369ewy.37
        for <git@vger.kernel.org>; Sat, 11 Jul 2009 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a/+YkEkcRjSH8rkeV57Vg6MwqYLhW0N4wl0rOQ7ilMA=;
        b=pf8dCrI1MQi+cnc7mdDGDJ90KUFCIj1ntvTGFL9nBqFv2yeVSCHj2gdIP4TkdFpGvj
         sArHH8KjVvyuMZElHXUVRwEZ20i7SuwqlqA1FCMDl2o3Kp7RqPKzED5NCvpANm24RY/p
         jBPZh4MKFPlFD6MWYf5vmY3Ry4Vn2M1IdkFmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SNUwUGGL/i2Fy3OesXfXZn0NiohPbByhCKZvavO4RGXHMNuuOsRksCSL2AK2Wa0Ocy
         kGlMrm1wwJH4gDfjLNM+bpeFcThi1f+mu54EwaJhmigXfWwGL9UGvv94L+K6N15JJCbq
         T2Uk993zlcNju4C7RTwh85MietXz68381SiOs=
Received: by 10.210.70.8 with SMTP id s8mr3507807eba.46.1247303851217;
        Sat, 11 Jul 2009 02:17:31 -0700 (PDT)
Received: from ?192.168.1.13? (abwp104.neoplus.adsl.tpnet.pl [83.8.239.104])
        by mx.google.com with ESMTPS id 5sm4501898eyf.54.2009.07.11.02.17.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Jul 2009 02:17:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4otkuqlq.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123104>

On Sat, 11 July 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Luben Tuikov changed 'lineno' link (line number link) from pointing to
> > 'blame' view at given line at blamed commit, to the one at parent of
> > blamed commit in
> >   244a70e (Blame "linenr" link jumps to previous state at
> >            "orig_lineno", 2007-01-04).
> > This made it possible to do data mining using 'blame' view, by going
> > through history of a line using mentioned line number link.
> 
> I was playing with this feature the other day (and I think you can guess
> what I was writing when I was doing so as preparation).  I was mildly
> annoyed that these links on the commit object names go to the commit view.
> 
> I think going to commitdiff view would make it far more useful while
> digging.
[...]

Also with a slight extension of diff part of 'commitdiff', by adding
line numbers for preimage in chunk and line numbers for postimage in
chunk, like e.g. in 'commit' view on GitHub[1] or on Gitorious[2] or
in SVN::Web[3] or in Atlassian FishEye, and adding anchors for those
line numbers we could go to given line in dif/patch output and examine
how it looked like before.

 [1] http://github.com/jnareb/softsnow-xchat2-filter/commit/7b68fcd777f94534f0b794c5dc2e109c49938395
 [2] http://gitorious.org/softsnow-xchat2-filter/mainline/commit/7b68fcd777f94534f0b794c5dc2e109c49938395
 [3] http://jc.ngo.org.uk/svnweb/jc/diff/nik/CPAN/SVN-Web/trunk/README?revs=1283&revs=981

(This would probably require adding 'fmt' / 'format' parameter, where
one could choose between possible ways to view diff, or possible ways
to view log or log-like view.)


P.S. BTW. 'blame' view passes _original_ filename (not filename at
blamed commit) to 'commit' view link... but it doesn't matter because
'commit' view does not use 'f'/$file_name parameter.
-- 
Jakub Narebski
Poland
