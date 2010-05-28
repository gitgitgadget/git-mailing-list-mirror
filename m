From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: git pull works remotely but not locally
Date: Fri, 28 May 2010 09:24:39 +0100
Message-ID: <4BFF7DC7.6030806@llaisdy.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTimDOOjbCRJMOlW8sTEtiHdI4AqjdOcdFug7MD94@mail.gmail.com> <4BFE9172.9080209@llaisdy.com> <201005272153.54239.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 28 10:24:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHus6-0004A3-4h
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 10:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab0E1IYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 04:24:44 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:38655 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759Ab0E1IYl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 04:24:41 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 3E835DEC64
	for <git@vger.kernel.org>; Fri, 28 May 2010 09:24:40 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id KJda2yc+krBy for <git@vger.kernel.org>;
	Fri, 28 May 2010 09:24:40 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id C1459DEBD6
	for <git@vger.kernel.org>; Fri, 28 May 2010 09:24:39 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201005272153.54239.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147918>

Dear Hannes

Yes, you have pinpointed it.  I installed as root, but I thought I had 
followed the other instructions (using ./configure) and did

    # make configure
    # ./configure --prefix=/opt
    # make
    # make install


In any case, I have deleted everything and reinstalled properly.  Now 
git pull is working as it should.

Thank you all for your patience and help.

Best wishes

Ivan


On 27/05/2010 20:53, Johannes Sixt wrote:
> On Donnerstag, 27. Mai 2010, Ivan Uemlianin wrote:
>    
>> - I did configure with prefix=/opt
>> - odd thing: nothing was installed into /opt: it all went into /root (I
>> might have been root for the whole process, which I know is bad).  I
>> just cp'd everything over to /opt, and everything worked OK (until now).
>>      
> My guess is:
>
> - You built as root.
> - I don't know what went wrong with the command that involved prefix=/opt.
> - But when you finally build using 'make', it picked the default prefix, which
> is /root when you are root.
> - This hard-codes the libexec path to /root/libexec/git-core.
> - Even after you copy the stuff to /opt, git looks in /root/libexec/...
> - As a normal user you do not have access to /root, ergo, Permission denied.
>
> Rebuild as normal user with
>
>     make prefix=/opt
>
> and install as root with
>
>     make prefix=/opt install
>
> (Yes, prefix must be given also for 'make install'.)
>
> -- Hannes
>    


-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================
