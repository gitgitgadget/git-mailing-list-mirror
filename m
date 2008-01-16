From: Mike <fromlists@talkingspider.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 12:23:09 -0500
Message-ID: <478E3D7D.4000700@talkingspider.com>
References: <478D79BD.7060006@talkingspider.com> <ee77f5c20801152006w11307ce0j17463f1c6536543f@mail.gmail.com> <478D85A9.6050807@talkingspider.com> <D017F6F6-D674-428B-936B-181BF20CF4B5@vicaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFBzW-0008UH-Bt
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYAPRXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbYAPRXN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:23:13 -0500
Received: from relay03.pair.com ([209.68.5.17]:1572 "HELO relay03.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750943AbYAPRXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:23:12 -0500
Received: (qmail 72859 invoked from network); 16 Jan 2008 17:23:10 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 16 Jan 2008 17:23:10 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <D017F6F6-D674-428B-936B-181BF20CF4B5@vicaya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70704>



Luke Lu wrote:
> 
> On Jan 15, 2008, at 8:18 PM, Mike wrote:
> 
>>
>> David Symonds wrote:
>>> On Jan 16, 2008 2:27 PM, Mike <fromlists@talkingspider.com> wrote:
>>>> 2. If I tar/gz my code and deliver it to a client, I don't want the 
>>>> .git
>>>> dir slipping into the tarball, allowing my client to be able to peruse
>>>> the history of what we did and when.
>>> Use git-archive.
>>
>> Thanks but this isn't sufficient. If we have one directory of our web 
>> root in a git repository, say docroot/php, and we tar up docroot, it 
>> will include php/.git.  We don't want that.  We would have to go out 
>> of our way to avoid the .git directory.  The point is, we don't want 
>> anything in docroot that shouldn't be made live.
> 
> git-archive generates an archive file *without* the .git directory. From 
> git-archive(1):
> 
>   git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ && tar xf -)
>               Create a tar archive that contains the contents of the latest
>               commit on the current branch, and extracts it in 
> /var/tmp/junk
>               directory.
> 
>   git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip > 
> git-1.4.0.tar.gz
>               Create a compressed tarball for v1.4.0 release.
> 
>   git archive --format=tar --prefix=git-1.4.0/ v1.4.0^{tree} | gzip 
>  >git-1.4.0.tar.gz
>               Create a compressed tarball for v1.4.0 release, but without a
>               global extended pax header.
> 
>   git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ > 
> git-1.4.0-docs.zip
>               Put everything in the current head's Documentation/ directory
>               into git-1.4.0-docs.zip, with the prefix git-docs/.
> 
> IMHO, git export is probably a better name for the command. git-archive 
> sounds like backup everything associated with git.
> 
> __Luke
> -

OK I don't think you read my response closely.  I wasn't going to 
respond except I see Johannes missed the point too.

I completely understand that git archive will not inlcude the .git dir. 
What you missed in my response is the case where someone tars up a 
directory above the .git directory. Not all of the content under doc 
root is in a git archive.
