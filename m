From: Farrukh Najmi <farrukh@wellfleetsoftware.com>
Subject: Re: Why is TreeWalk.forPath(...) returning null
Date: Wed, 12 Nov 2008 17:52:54 -0500
Message-ID: <491B5E46.6000706@wellfleetsoftware.com>
References: <491B579E.6050408@wellfleetsoftware.com>
 <20081112224236.GX2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:54:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0ObB-0004jL-P7
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYKLWwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbYKLWwz
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:52:55 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:47895 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYKLWwy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:52:54 -0500
Received: from [192.168.1.101] ([71.184.206.167])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA800746SW41CS0@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 12 Nov 2008 16:52:53 -0600 (CST)
In-reply-to: <20081112224236.GX2932@spearce.org>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100829>

Shawn O. Pearce wrote:
> Farrukh Najmi <farrukh@wellfleetsoftware.com> wrote:
>   
>> My "git status" command shows:
>>
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #    modified:   xml/minDB/SubmitObjectsRequest_CMSScheme.xml
>>
>> The file above was committed and then modified. I want to use jgit to  
>> find the comitted version of that file.
>>
>> When I do the following code I get a null treeWalk? Why is that? What  
>> should I specify for path instead?
>>
>>            String path = "xml/minDB/SubmitObjectsRequest_CMSScheme.xml";
>>            String versionName = Constants.HEAD;
>>
>>            Commit commit = repository.mapCommit(versionName);
>>
>>            if (commit == null) {
>>                log.trace("Did not find Commit. versionName:" +  
>> versionName);
>>            } else {
>>                ObjectId[] ids = {commit.getTree().getId()};
>>                TreeWalk treeWalk = TreeWalk.forPath(repository, path, ids);
>>            }
>>     
>
> Huh.  That should have worked.
>
> TreeWalk.forPath returns null if the path doesn't get found.  So
> it sounds like jgit isn't matching the path.  Its a pretty simple
> operation, I'm not sure why its failing here.  I'd run it through
> a debugger to try and see why the TreeWalk didn't match your path.
>
> Your code is logically the same as:
>
>   git rev-parse HEAD:$path
>
> so it should find the blob if Git would have found it.
>
>   

My bad. I had a type in the path in my junit test  :-[
Its working as expected. Thanks.

-- 
Regards,
Farrukh Najmi

Web: http://www.wellfleetsoftware.com
