From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rename handling
Date: Thu, 22 Mar 2007 04:32:25 +0100
Message-ID: <200703220432.27071.jnareb@gmail.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <200703220301.41180.jnareb@gmail.com> <46a038f90703211939j15dbda4cpfa2f49229b8c16cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 04:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUDzh-0002Il-3u
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 04:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbXCVD3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 23:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965636AbXCVD3c
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 23:29:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:48369 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964848AbXCVD3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 23:29:31 -0400
Received: by ug-out-1314.google.com with SMTP id 44so565136uga
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 20:29:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VXNTGR0rwnsvloqe+ITmHdLMjbQ9QUMmdKnlDiw8Ci2G1NLxFlr1jzqqiBxH6WOpFSjSmvNtV8sLK4BO9Q47UCg2mVK15FqVRuooyOiG5TADzNimcYbx0n1Kujy9r46ZPVDMpRWHybZtQtgpMtfyGP3/SX0JPKUgcMBkfRo9ggw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tAGJ3bOiJx/z8LsJmgRerlwE4PfPkDUqVFy+CfLEzaBWcuWvqjk3pYXEuP3sPOy5MsndkAL7OhZ4iDoNktYJmDEjH7ElsvywS5NwF39Q8Q2sZDCgBXcTZmM+uva8PCpAwXY+7mCHRrrN8HPoLPoIBM463qyGDTgiDQqY2ewnWaM=
Received: by 10.67.19.17 with SMTP id w17mr4181607ugi.1174534170486;
        Wed, 21 Mar 2007 20:29:30 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w7sm8644493mue.2007.03.21.20.29.28;
        Wed, 21 Mar 2007 20:29:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <46a038f90703211939j15dbda4cpfa2f49229b8c16cb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42835>

Martin Langhoff wrote:
> On 3/22/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> Additional issue that we have to think about with respect to rename
>> support for merges is that git uses 3-way merge, taking into account
>> _only_ upstream commit (of the branch we want to merge to), side branch
>> commit (of the branch we want to merge) and common ancestor[*1*]
>> (merge base) for merging. What is important is that the intermediate
>> states, how we got to the current state, does not matter.
>>
>> Well, one could argue that if we remember explicit (provided by user)
>> info about renames for example in proposed 'note' field of a commit
>> object, or in other helper structure (we cannot remember the information
>> in blob or tree), we can gather and remember information about recorded
>> explicit renames when finding common ancestor...
> 
> But we do have some of that already - if one trees being merged is
> missing a path that changed on the other one, we walk back on the
> ancestry looking for renames.
> 
> Or am I seeing things?

First, I was talking about hypotetical manually-provided helper information
about explicit renames, entered by user, not guessed by SCM.

Second, I have thought that rename detection is done on final states: upstream,
branch and ancestor, not on intermediate commits. I guess I thought wrong.
 
-- 
Jakub Narebski
Poland
