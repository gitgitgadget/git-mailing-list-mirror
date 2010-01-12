From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 19:37:47 +0100
Message-ID: <4B4CC17B.30303@dbservice.com>
References: <1263319565-sup-1767@ezyang> <28c656e21001121029h42544f3er6eedf8465851fec1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Edward Z. Yang" <ezyang@mit.edu>, git <git@vger.kernel.org>
To: B Smith-Mannschott <bsmith.occs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:38:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUldI-0008R1-Rt
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 19:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab0ALSiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 13:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067Ab0ALSiU
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 13:38:20 -0500
Received: from office.neopsis.com ([78.46.209.98]:52604 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab0ALSiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 13:38:19 -0500
Received: from [192.168.0.82] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Tue, 12 Jan 2010 19:38:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.3a1pre) Gecko/20100107 Lightning/1.1a1pre Shredder/3.2a1pre
In-Reply-To: <28c656e21001121029h42544f3er6eedf8465851fec1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136747>

On 01/12/2010 07:29 PM, B Smith-Mannschott wrote:
> On Tue, Jan 12, 2010 at 19:10, Edward Z. Yang<ezyang@mit.edu>  wrote:
>> I have a few friends that still use RCS for their version control
>> needs.  We have argued over various points between RCS and Git, and
>> as far as I can tell the one thing RCS has that Git does not is
>> a locking mechanism.  That is to say, co -l checks out a file and
>> also gives you a lock on it, preventing others from futzing with it,
>> and ci -u checks in the file and releases your lock.  This is
>> useful if you have a shared working copy on a multiuser system or
>> on a network file system, and you don't want conflicts.
>>
>> I was wondering if there would be interest in such a feature on
>> the Git developers side.
>
> How do you imagine that this would work in a distributed system such
> as git? What would it mean to have the lock for "a file", when each
> user effectively has their own branch?

He mentioned a shared working copy, in which case there can be problems 
if multiple users edit the same file.

Usually you'd work around that by cloning the repo, working in the 
clone, and push the result back. This can get a bit tricky if the main 
repository is not bare, but there is a solution even to that (either 
explicitly run git reset --hard or have a post-receive hook which 
updates the working tree).

tom
