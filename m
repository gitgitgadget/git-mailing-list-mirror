From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] jn/gitweb-blame fixes
Date: Sat, 21 Nov 2009 01:32:42 +0100
Message-ID: <200911210132.44649.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <4B05EA37.7060704@gmail.com> <4B06157B.10203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 01:33:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBduN-0002yV-6v
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 01:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZKUAcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 19:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbZKUAcr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 19:32:47 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:40604 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbZKUAcq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 19:32:46 -0500
Received: by ewy19 with SMTP id 19so255448ewy.21
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 16:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4iXRDTo5ezlklo13BS9k8RcrJWaHyKuanOrLJCgQbks=;
        b=aBIB9SMa6mSTQcaxgKIIWeyp2LB4kC/gKyqHYCFIuQ7pfb/obEKS5UzVrEAADiHiBS
         UyEt8MPXP04B2RL8ieL47LGic+kduKoRnUi/bMDQfJsBMIzDL9/OkD1SSalc5Ow3DUbr
         zbdvvSBfnG9yEqHzy3KHVyWYNQ2GcGF30ii/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=W4nyCye6pGt5C+/hw+pLQtPCcVycuxGEo1p+5We55WNNXcjy1n89loyyIAOMN94P4c
         tgvZteUq0ksO8pWuaPhwHp+c16vz0O42qt1CVzr6F54Pd68RLOdQYj0awGACVMeilXzL
         oQSZg8yLqdyhfDNTwgInnCA8dJTWYOFGOrdKY=
Received: by 10.213.107.16 with SMTP id z16mr1981135ebo.47.1258763571578;
        Fri, 20 Nov 2009 16:32:51 -0800 (PST)
Received: from ?192.168.1.13? (abvw56.neoplus.adsl.tpnet.pl [83.8.220.56])
        by mx.google.com with ESMTPS id 28sm495080eyg.44.2009.11.20.16.32.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 16:32:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B06157B.10203@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133388>

On Fri, 20 Nov 2009, Stephen Boyd wrote:
> Stephen Boyd wrote:
> > Jakub Narebski wrote:
> > >
> > > Thanks for working on this.  Also it is nice to have incremental blame
> > > tested for another browser, beside Mozilla 1.17.2 and Konqueror 3.5.3
> >
> > For those following along, Opera-10.10 has been tested and works.
> 
> Ok. I tried using the version of incremental blame that's in next 
> (e206d62 gitweb: Colorize 'blame_incremental' view during processing, 
> 2009-09-01) on IE8 with no success. The page loads and the file is shown 
> with line numbers, but the progress is stuck at 0% (with the &nbsp; 
> showing too).
> 
> I then tried with my two patches applied on top of e206d62 on IE8 and 
> still no success. The page loads and the file is show with the line 
> numbers but still stuck at 0%, but the &nbsp; is gone at least.
> 
> Do you have access to IE8 to confirm?

I have tested gitweb with both of your patches applied, serving gitweb
as CGI script using Apache 2.0.54 on Linux, and viewing from separate
computer on MS Windows XP, with the following results:

* For the following browsers blame_incremental view on gitweb/gitweb.perl
  file produces correct output, but for progress info which instead of
  (  1%) -> ( 29%) -> (100%) looks more like ( 1%) -> (29%) -> (100%)

  + Firefox 3.5.5 (rv:1.9.1.5 Gecko/20091102)
  + Opera 10.01
  + Google Chrome 3.0.195.33

* Testing it with IE8 (Internet Explorer 8.0.6001.18702) page loading stops
  at 0%, at the very beginning on startBlame() function

  IE8 shows that it finds the following errors:

  * "firstChild is null or not an object"
    line: 565, char:4

      a_sha1.firstChild.data = commit.sha1.substr(0, 8);

    It might be caused by the fact that firstChild for this case should be
    text node containing of pure whitespace:
       <a href=""> </a>
    Perhaps IE8 simplifies it in "compatability view" mode

 * "Unspecified error" (twice)
   line: 777, char:2

     if (xhr.readyState === 3 && xhr.status !== 200) {
     	return;
     }

   I don't know what might be the source of error here; I suspect that the
   error position mentioned by IE8 is bogus.

-- 
Jakub Narebski
Poland
