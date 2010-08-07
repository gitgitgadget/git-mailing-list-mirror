From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Sat, 07 Aug 2010 04:48:02 -0400
Message-ID: <4C5D1DC2.6000704@gmail.com>
References: <4B7D8358.1080108@gmail.com>	<fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>	<4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>	<4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>	<4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix>	<p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>	<AANLkTi=a27OtQX-oNwPqmXDUmZHFyKo+fPZCRgSv04G3@mail.gmail.com> <8762znjdr0.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>,
	conrad@metadecks.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 07 14:13:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiGm-0004JG-FY
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0HGIsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 04:48:12 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50837 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab0HGIsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 04:48:08 -0400
Received: by qwh6 with SMTP id 6so5718004qwh.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Fecv5PuabZ54GFbMtF05bRmMXrm3JWu0iCQO4SfNu50=;
        b=hT8CXSC9IRH5WMcpRxlgBZknwwihxdbi6Gmbb76YX/X9YwaUDHrmKwiEd0aLPTqrm+
         gUupnRASL4lQdWIG3d05LMnH902C5P7S11RCXzDiNmYAZS2oG2QSwRYZTxHKJKdELwP3
         Nn789t5KIDbUJZQIIVz/pbraQfkNYkMkhdg/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QTpcesRJNCzz17dd59M2Oegl3EDKyvV9NHN+gtPhQ7OBROfvEZK8CG3mOJTGGtoFQt
         EcN5x8XBv1hYVqSRkp565y7HyibHcdtYVUQIX4M4rPQx/raFWckUgZPIIafPr6zExSwU
         j5mwMTC0hSjTNB1BJkzQIAkxxvlUHP7lnWVIA=
Received: by 10.224.45.30 with SMTP id c30mr2168323qaf.87.1281170885228;
        Sat, 07 Aug 2010 01:48:05 -0700 (PDT)
Received: from [192.168.2.205] (dsl-153-72.aei.ca [66.36.153.72])
        by mx.google.com with ESMTPS id q8sm460776qcs.0.2010.08.07.01.48.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 01:48:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100515 Iceowl/1.0b1 Icedove/3.0.4
In-Reply-To: <8762znjdr0.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152849>

(restoring CC list. it is customary on the git list to reply-all)

On 2010-08-06 23:36, Miles Bader wrote:
> Conrad Parker <conrad@metadecks.org> writes:
>> Anyone interested in git-bzr might also want to look at some recent
>> rewrites; from the current git-bzr README:
>>
>> The following are rewrites in Python and may offer better bzr integration:
>>   * http://github.com/termie/git-bzr-ng
>>   * http://github.com/matthew-brett/git-bzr
>>
>> (... and I'd also be interested to know how well either of these work :)

I've found some time to begin implementing a remote-helper[1] this week.
Plugging in a call to "bzr fast-export" made cloning a repository with
"git clone bzr::url" and pulling new revisions in with "git pull" work
with minimum effort.

[1]:http://github.com/lelutin/git-remote-bzr

However, as reported in this bug[2], the fast-import path to push
commits back to bzr is broken in the bzr plugin. Once we get this
working, we should be able to round-trip.

[2]:https://bugs.launchpad.net/bzr-fastimport/+bug/347729

Doing "git pull" currently exports all history from the Bazaar branch to
incorporate the needed commits in the git repo. This is really
suboptimal, but I thought having something that works before making it
work right would help me get some insights on the remote-helper's code.


The very cool thing about making this into a remote-helper instead of a
git command in itself, is that we won't have to redisign (and possibly
re-implement) the command line interface, since git will be calling the
remote-helper with the right commands at the appropriate time.

-- 
Gabriel Filion
