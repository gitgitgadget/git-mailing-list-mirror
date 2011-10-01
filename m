From: david@lang.hm
Subject: Re: Does git have "Path-Based Authorization"?
Date: Fri, 30 Sep 2011 19:09:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1109301904410.14711@asgard.lang.hm>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com> <1317427503.4331.37.camel@centaur.lab.cmartin.tk> <CAN0CFw0+v9qscJ+isQdwJOHT4Ajsk-96QK8gQFsu9E87a3j+Ww@mail.gmail.com> <CACsJy8Dm-vSoki9Fr7s=DH7oRYL-a=kF7q9mBwo55ZxsLg5DTA@mail.gmail.com>
 <CAN0CFw1-Edb5PdoTzJz38vJOjjXVAg6F24XgHpTi+3e5C7yxfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1068516109-1317434981=:14711"
Cc: git@vger.kernel.org
To: Grant <emailgrant@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 04:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9p1Y-0006Gi-RK
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 04:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab1JACJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 22:09:44 -0400
Received: from mail.lang.hm ([64.81.33.126]:56941 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab1JACJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 22:09:43 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p9129fwb022889;
	Fri, 30 Sep 2011 19:09:41 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CAN0CFw1-Edb5PdoTzJz38vJOjjXVAg6F24XgHpTi+3e5C7yxfQ@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182533>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1068516109-1317434981=:14711
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 30 Sep 2011, Grant wrote:

>>> I have a series of files containing server-side code which make up a
>>> website.  The entire layout contains only a few folders, but those
>>> folders contain many files.  I want to be able to allow access to only
>>> certain files at a time, sometimes only a single file.  Can that be
>>> done in the way you describe?
>>
>> If you can gather all sensitive files in a subdirectory, then you can
>> split that directory into its own repository (see git-submodule man
>> page) and grant limited access to that repo.
>> --
>> Duy
>
> I thought about separating files the dev has had access to into a
> separate folder from files the dev hasn't had access to, but it would
> mean constantly changing the code as files move around, plus it would
> be too complicated if I have multiple devs and want to give them
> access to different stuff.  It's not that some files are more
> sensitive than others, it's just that I don't want to give anyone
> access to more than I have to.

the thing to think about is why would you want to give a dev access to a 
file or restrict their access.

Remember that the Dev should be able to test their changes, so you really 
need to give them access to enough stuff to be a complete, working set.

If you make each set of things it's own repository, then you should have 
the granularity you are looking for.

If you think you will need more granularity, please explain what you are 
thinking of?

Also remember that you don't want to have your development files on your 
production site, so you probably don't want to deploy directly from your 
repository to the production site. If you use a filter to make a new git 
repository that only contains the pieces that you are wanting to publish, 
and keep that repository clean, only submitting the files that you want 
there, but treat it as a read-only repository (i.e. no development work 
done there), you should be in good shape.

David Lang
--680960-1068516109-1317434981=:14711--
