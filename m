From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Query remote repository files, blobs
Date: Sat, 19 Dec 2009 15:42:25 -0500
Message-ID: <4B2D3AB1.5000504@gmail.com>
References: <d16b1c80912182345h4163430bv810adb860575d67a@mail.gmail.com> <alpine.DEB.1.00.0912191159280.4985@pacific.mpi-cbg.de> <19244.54684.250532.801766@lisa.zopyra.com> <20091219192415.GC10687@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Shakthi Kannan <shakthimaan@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 19 21:42:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM68M-0002vJ-O0
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 21:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZLSUme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 15:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbZLSUmd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 15:42:33 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:57477 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbZLSUmd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 15:42:33 -0500
Received: by ywh12 with SMTP id 12so4528122ywh.21
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 12:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=39mjJxELtR4eufR4a1BgqCbKw8/51ObsxV7DKqW/Cfc=;
        b=VI2IfnSlcrqViDqaZpqkfaovWUOLEkQcXQqDykBcAChL2UMUdD9gcF2d8eLfLdcLRS
         dHqckQRcX93J1tiAE6tWRiEmRcKKJHQU0SevP92F2aCT18QB7T000tt1Uuz5R+SHOr3L
         ML1mZ02QzgvWz8OXdfdHzqiKsUl2mwI020l9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=RY1DJWMZx4VTfhbtEp/1HuyVDNUJqIemS+2Il3k5h2TMDvz0XxXhoY70fJu88oCENR
         icDdmtXxpD2z6WIOW1sOvtHO9Bn8UOjXTlFfX2cDZBd0yq76DN+poBhlIfF5QXv3MhDR
         UeTfENC2iFGfMl3GwGtnLidbsByXl4O3LGu8A=
Received: by 10.150.120.27 with SMTP id s27mr8781722ybc.49.1261255351074;
        Sat, 19 Dec 2009 12:42:31 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 6sm1550864ywd.37.2009.12.19.12.42.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Dec 2009 12:42:30 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20091219192415.GC10687@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135499>

Shawn O. Pearce wrote:
> Bill Lear <rael@zopyra.com> wrote:
>> On Saturday, December 19, 2009 at 12:02:02 (+0100) Johannes Schindelin writes:
>>> On Sat, 19 Dec 2009, Shakthi Kannan wrote:
>>> ...
>>>> I am able to query for list of remote heads, and tags. I would like to
>>>> know if it is possible to query for information on remote files, or
>>>> blobs?
>>> This has been discussed a number of times, but we cannot allow that for 
>>> security reasons.  A blob might contain confidential information, in which 
>>> case the branch has to be rewritten and force-pushed.  However, that does 
>>> not make the blob go away, but makes it only unreachable.  Until the next 
>>> garbage collection kicks in, that is (which you typically cannot control).
>> Hmm, I thought this had been addressed by git in a different way (removing
>> confidential information).  A company will not be satisfied that its
>> proprietary information is "unreachable" in your software repository.
>> They want absolute assurance that the information is completely
>> removed.
>>
>> Have I remembered wrongly --- is this still not possible with git?
> 
> Its still possible, but you have to wipe out the reflog record(s)
> that had the object in it, and you have to repack to evict it from
> the pack files, and you have to run `git prune --expire=0` to force
> it to wipe out the object immediately.
> 
> We already support dumping back random commits via upload-archive, if
> its enabled in the daemon, and I think a lot of people do turn it on.
> There is no validation that the requested tree-ish is reachable.
> 
> I think gitweb winds up doing the same thing, it doesn't actually
> try to validate the object is reachable, it just serves whatever
> it was asked for, if its present in the repository.
> 
> 
> I'm getting some mild suggestions over here at $DAY_JOB to implement
> shallow clones by lazily downloading large blobs on demand.
> We've resisted doing this in git because of the reachability test
> Dscho mentioned above... but many people skip that anyway due
> to gitweb and upload-archive being enabled.  Which is making me
> start to question who is broken... upload-pack for not being more
> willing to serve arbitrary content, or gitweb/upload-archive for
> not validating their requests are reachable.

The security argument hasn't been true for a while if any of the 
following are enabled on the server:
	Gitweb
	http transport
	rsync transport
	ftp transport
	alternates (the alternates are the ones at risk)
