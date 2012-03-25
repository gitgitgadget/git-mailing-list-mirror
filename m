From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sun, 25 Mar 2012 18:55:19 +0100
Message-ID: <201203251955.21454.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203241949.04956.jnareb@gmail.com> <CACeyogdkEdkYa+SQvUq50FU5P7ohq-tLf8tgi1v6o_HMM5bSsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 19:55:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBrfA-0002pa-O0
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 19:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab2CYRz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 13:55:27 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48856 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704Ab2CYRz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 13:55:27 -0400
Received: by wibhj6 with SMTP id hj6so3590517wib.1
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=rvrugVag6ufwsHPiQrHs4FkbWWS9Du3vJ72alMMcfhQ=;
        b=w3ZmF6lpkdF0HBvhVo9tChsTtXBGjYYOSPlmf0SeTXknQN4zn1kD/Mu5IWuXzXasDL
         POAv9vdu8FwlkDuVVAjq7QLP1FFTQuT+62krlkYIdm50+aB+zdFjQvNvyYunGuIHyeg4
         HGQv6jAbJ+HJLY0Yjm3JlJmdXtQ6h2xrw1fhHZxwpR2xHpd3jFogre2T8Hd/4uAW4nU0
         Iuun1coqgC4zt0XArZccC7yIuUP44ydxa2eiARB1+TWufJ9LynfDn0xMN1iwHo6RZ29a
         R/fpfG0gMma74yDiX8haQ0x6wDT8kLKWxHo5wKfTNvdv57QSJ9S+pfAmNaFHXSsNQbAm
         rRxQ==
Received: by 10.216.132.169 with SMTP id o41mr10853116wei.121.1332698125654;
        Sun, 25 Mar 2012 10:55:25 -0700 (PDT)
Received: from [192.168.1.13] (addd160.neoplus.adsl.tpnet.pl. [79.184.55.160])
        by mx.google.com with ESMTPS id n8sm55439490wix.10.2012.03.25.10.55.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 10:55:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyogdkEdkYa+SQvUq50FU5P7ohq-tLf8tgi1v6o_HMM5bSsg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193879>

On Sun, 25 Mar 2012, chaitanyaa nalla wrote:

> Dear Jakub,
> 
> if we handle the sorting of the tables on the client side itself,
> will that be a  load on the browser?

Well, if it turns out to be too heavy a load, we can use the same trick
of "timed array processing":

  http://www.nczonline.net/blog/2009/08/11/timed-array-processing-in-javascript/

See for example this page to see sorttable in action:

  http://en.wikipedia.org/wiki/Comparison_of_open_source_software_hosting_facilities

> Other ideas which I have in mind are
> 
> 1. Highligting matched portions of project name while searching the
>    project name, even more intuitively

You probably couldn't have known that match highlighting in project
search is done on server side by gitweb.cgi since commit 6759f95
(Merge branch 'jn/gitweb-hilite-regions', 2012-03-04):

  gitweb: Highlight matched part of shortened project description
  gitweb: Highlight matched part of project description when searching projects
  gitweb: Highlight matched part of project name when searching projects

It is not used by either git.kernel.org or repo.or.cz because it is
too fresh (it is to be in yet to be released v1.7.10).

> 2. project pagination.

Is there any sense in pagination on client side?  Unless you turn it into
lazy loading / loading on demand Ajax-y pagination...


Yet another idea is to implement creating side-by-side diff from unified
diff in JavaScript, so that swicthing between unified and side-by-side
diff view could be done entirely client-side, without hitting the server.


Note however that I think that it wouldn't be possible in time given to
implement all those ideas.  You need to select those of them that you
will put in project application.

-- 
Jakub Narebski
Poland
