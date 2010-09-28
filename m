From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Makefile: Add help target
Date: Tue, 28 Sep 2010 14:35:27 +0200
Message-ID: <4CA1E10F.4080906@op5.se>
References: <1285661638-27741-1-git-send-email-bebarino@gmail.com> <7v39suurpw.fsf@alter.siamese.dyndns.org> <AANLkTi=beUW5j4WSGOB__LNP7o60Wep_Y9n4YXOZUMtU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 14:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ZPq-0007fY-Q8
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 14:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab0I1MgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 08:36:08 -0400
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:35108 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753325Ab0I1MgH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 08:36:07 -0400
Received: from source ([209.85.215.44]) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTKHhNM96dqsN5aPrWLNo9Zw+L9CTTNpP@postini.com; Tue, 28 Sep 2010 05:36:07 PDT
Received: by mail-ew0-f44.google.com with SMTP id 26so2371417ewy.31
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 05:36:04 -0700 (PDT)
Received: by 10.213.32.135 with SMTP id c7mr17341ebd.2.1285677364143;
        Tue, 28 Sep 2010 05:36:04 -0700 (PDT)
Received: from clix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id u9sm10367031eeh.17.2010.09.28.05.35.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 05:35:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <AANLkTi=beUW5j4WSGOB__LNP7o60Wep_Y9n4YXOZUMtU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157416>

On 09/28/2010 01:37 PM, Sverre Rabbelier wrote:
> Heya,
> 
> On Tue, Sep 28, 2010 at 11:45, Junio C Hamano<gitster@pobox.com>  wrote:
>> I do not look forward to having to maintain a large number of lines that
>> are doomed to go stale
> 
> How often have we changed makefile targets recently? The most recent
> one that I can find is Jakub adding "install-gitweb" in 152d94348f,
> which was back in May 1st. The next one before that is the addition of
> 'gitweb' in 62331ef1637f which was back in January 30th. Besides,
> 'make help' doesn't have to contain _all_ Makefile targets, just the
> important ones that a user is most likely to need. Similar to 'git
> help' itself.
> 
>> and every time we need to touch we need to deal
>> with a lot of noise "@echo '"?
> 
> I don't understand what is particularly bothersome about the leading
> "@echo" lines. Adding or removing a target is still very easy even
> with the leading @echo's, the only thing that would be a PITA is
> reflowing paragraphs, currently, there _are_ no paragraphs, everything
> fits on one line.
> 
>> It might be a bit less distasteful if it were plain text additions at the
>> end of INSTALL file, though.
> 
> That does not help me nearly as much when I want to know how a
> makefile target is called. Am I wrong in asserting that having a "make
> help" target is an accepted "good practice" in the unix world?
> 

help:
    @echo Available make targets:
    @echo -----------------------
    @$(MAKE) --print-data-base --question | \
	sed -n -e '/^Makefile/d' -e 's/^\([a-z0-9_-]*\):.*/\1/p' | \
	sort | uniq | grep -v -e ^git -e ^test-

Automatically self-managing and seems to print most sensible targets.
Adjust to taste with whatever's appropriate.

Users with a too-old make program (pre 3.67, I think), won't be able
to use the help target, but that's perfectly acceptable imo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
