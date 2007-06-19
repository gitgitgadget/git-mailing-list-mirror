From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT rebasing safeguard
Date: Tue, 19 Jun 2007 23:12:30 +0100
Message-ID: <b0943d9e0706191512l5f19b80v5b5be9151be13025@mail.gmail.com>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
	 <20070611003330.4736.69293.stgit@gandelf.nowhere.earth>
	 <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com>
	 <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070614213032.GR6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0lwC-0000oG-Ee
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 00:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437AbXFSWMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 18:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbXFSWMc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 18:12:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:32032 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325AbXFSWMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 18:12:31 -0400
Received: by ug-out-1314.google.com with SMTP id j3so217603ugf
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 15:12:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pGR58vYfl8VOfEAkSpwSodldmkE/WF/EHgTDoh7psR42TJzKR3du59nYYLRjKPAEOksQJP3NF7oGqKftzPa3H9Pu90F9b47LeU7lgoRkDW0e/4hJSo5uuyXi0JkAL2t6QUyxspgVSO2ej3Jmq0CgF5c7+cP5lMAnOLvHFH1wJBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Npk7d9Vz/9UWzC20x9jXuExF+F7MksirSslLV7FBeR+nIiav3e1GAx0WiOK1OSrr8UOPoEYVJ46VNIe1Tt6cj01AqdE7fEQGrkl9MaSDGwIAAvA6xDAXOZTKbEvNsezhU7gpFst3aeLhW03lz25CLwRNMHtkpSgAWGiKcMc1XxA=
Received: by 10.66.248.8 with SMTP id v8mr742648ugh.1182291150109;
        Tue, 19 Jun 2007 15:12:30 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Tue, 19 Jun 2007 15:12:30 -0700 (PDT)
In-Reply-To: <20070614213032.GR6992@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50514>

On 14/06/07, Yann Dirson <ydirson@altern.org> wrote:
> When the parent branch is a rewinding one (eg. an stgit stack), then
> the old version of the patch will be turned to unreachable by
> pull/rebase, and we probably have even no way of telling stgit that it
> is indeed expected, since the parent stack is a local one.  My own
> workflow on StGIT is affected by the issue, since my "bugs" stack is
> forked off my "master" stack (but hopefully an hydra will help me ;).

If I understand correctly, is this the case where you do a 'stg
commit'? This command is meant for branches that are never rebased
(i.e. my master stgit branch). For this branch one wouldn't have a
remote branch configured and hence git fetch shouldn't do anything.

> That makes me suspecting the reachability approach is a dead-end, and
> we should either get back to the approach of recording old-base, or
> find another solution.

Maybe defaulting to 'git pull' and only use 'git fetch' if explicitly
asked. A git-pull would still keep the old patch accessible from HEAD.

-- 
Catalin
