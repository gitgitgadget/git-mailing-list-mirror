From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 3 Dec 2010 14:02:48 +0100
Message-ID: <201012031402.49169.jnareb@gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <201012031213.06321.jnareb@gmail.com> <201012031222.33635.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 03 14:03:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POVI4-0002TJ-J4
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 14:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605Ab0LCNDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 08:03:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45327 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LCNDB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 08:03:01 -0500
Received: by fxm20 with SMTP id 20so2152464fxm.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 05:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bQjaf1GFQABO71HxzjOaFlAegwIBwvEOR3Itzs2DTCw=;
        b=u0G41kBg8LczM3f7OzDfA/VL4G/Yzxzm9MgRvv9rvJvNMM3wTinGYOIselrBOE+oew
         d2rX+/wgrDBPT6TspF91lCO3h88hS/v6vT/gbYBDku6V7eUCVVXJLIerxYgWsWbxIt0j
         otCXK9z3V0scazIOCUXmz80CzI7+XEEBo0DZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q7Q8zp8Zvc/4ae0StylD3JUrXZqn1GAevvKfcRJfQE854nqFY+OyhhFKSNc9vZSEq+
         OcjPoJkKKswZAPmQTfMVRTsfM+AOWmuoH3a9tbLT8L6WzCRkE3kGdQi4TKncwbCX0AoX
         9zSHWjQ0OBgLxuMVn0Wzf2VbNloUR5j+X8SwA=
Received: by 10.223.86.8 with SMTP id q8mr323827fal.101.1291381380064;
        Fri, 03 Dec 2010 05:03:00 -0800 (PST)
Received: from [192.168.1.13] (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id a24sm230826fak.1.2010.12.03.05.02.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 05:02:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012031222.33635.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162795>

On Fri, 3 Dec 2010, Thomas Rast wrote:
> Jakub Narebski wrote:
> > On Fri, 3 Dec 2010, Thomas Rast wrote:

> > > "gitweb: File based caching layer (from git.kernel.org)" does not work
> > > on my automated tester:
> [...]
> > What are the results of relevant part of
> > 
> >  $ cd t
> >  $ ./t9502-gitweb-standalone-parse-output.sh --debug
> > 
> > output?
> 
>   ok 1 - setup
>   FULL_ID  = 1005c80cc11c531d327b12195027cbbb4ff9e3cb
>   SHORT_ID = 1005c80
>   not ok - 2 snapshot: full sha1
>   #       
>   #               gitweb_run "p=.git;a=snapshot;h=$FULL_ID;sf=tar" &&
>   #               check_snapshot ".git-$SHORT_ID"
>   #       
>   Status: 200 OK
>   Content-disposition: inline; filename=".git-1005c80.tar"
>   Content-Type: application/x-tar
> 
> They all fail after that, the rest of the output is at the end.  

Could you add 'exit' just after second test in 
t/t9502-gitweb-standalone-parse-output.sh test script, or running it
with `--immediate' option, and show us the results (after 'cd t') of

  $ file "trash directory.t9502-gitweb-standalone-parse-output/gitweb.body"
  should be:

    trash directory.t9502-gitweb-standalone-parse-output/gitweb.body: tar archive

  $ grep '<head>' "trash directory.t9502-gitweb-standalone-parse-output/gitweb.body"
  should be empty

  $ du -b "trash directory.t9502-gitweb-standalone-parse-output/gitweb.body"
  should be:

    10240   trash directory.t9502-gitweb-standalone-parse-output/gitweb.body

> OTOH if I check out v1.7.3.1-48-g5768176 instead, where the test
> works ok, it looks like this: [...]

Could you bisect to commit that introduces breakage?

Thanks in advance.
-- 
Jakub Narebski
Poland
