From: david@lang.hm
Subject: big files in git was: Re: Features from GitSurvey 2010
Date: Tue, 1 Feb 2011 14:50:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1102011443380.10088@asgard.lang.hm>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 23:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkPC1-0003TY-LF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 23:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab1BAW7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 17:59:14 -0500
Received: from mail.lang.hm ([64.81.33.126]:53946 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab1BAW7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 17:59:13 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Feb 2011 17:59:13 EST
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p11Mo3G7010358;
	Tue, 1 Feb 2011 14:50:03 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201102011451.17456.jnareb@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165874>

On Tue, 1 Feb 2011, Jakub Narebski wrote:

> On Sun, 30 Jan 2011, Jonathan Nieder wrote:
>> Hi Dmitry,
>>
>> Dmitry S. Kravtsov wrote:
>>
>>> I want to dedicate my coursework at University to implementation of
>>> some useful git feature. So I'm interesting in some kind of list of
>>> development status of these features
>> [...]
>>> Or I'll be glad to know what features are now 'free' and what are
>>> currently in active development.
>>
>> Interesting question.  The short answer is that they are all "free".
>> Generally people seem to be happy to learn of an alternative approach
>> to what they have been working on.
>>
>> [For the following pointers, the easiest way to follow up is probably
>> to search the mailing list archives.]
>>
>>> better support for big files (large media)
>>
>> For a conservative approach, you might want to get in touch with Sam
>> Hocevar, Nicolas Pitre, and Miklos Vajna.  The idea is to stream big
>> files directly to pack and not waste time trying to compress them.
>
> There is also, supposedly stalled, git-bigfiles project.

why is the clean/smudge approach that came through the list a week or two 
ago not acceptable?

While people talked about how it would be nice to store the large files on 
$remote_destination, just create a .git/bigfiles and store them in there.

with the ability to pass the filename to the clean/smudge scripts, you can 
even avoid the copy (replacing it with a mv) and have a working, if 
bare-bones system.

Then people can create/submit enhanced versions of these scripts that 
store the large files elsewhere if they want, but we would be past the 
"git can't handle large files" into "git handles large files less 
efficiently", which is a much better place to be.

If nobody else has time to take those e-mails and create a set of 
clean/smudge scripts, I'll do so later this week (unless there is some 
reason why they wouldn't be acceptable)

I guess the only question is how to tell what files need to be handled 
this way, but can't we have something in .gitattributes about the file 
size? (and if that's a problem for checking files out, have the stored 
file be a sparse file, that way it's large, but doesn't take much space on 
sane filesystems)

David Lang
