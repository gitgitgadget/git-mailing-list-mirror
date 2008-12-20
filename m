From: demerphq <demerphq@gmail.com>
Subject: Re: rsync deprecated?
Date: Sat, 20 Dec 2008 11:12:11 +0100
Message-ID: <9b18b3110812200212o46edf51eoaff43ec1b8fc3913@mail.gmail.com>
References: <200812180041.10312.markus.heidelberg@web.de>
	 <7vljuei2xw.fsf@gitster.siamese.dyndns.org>
	 <20081220081511.GA28212@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 11:17:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDytI-0004TY-He
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 11:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbYLTKMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 05:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbYLTKMO
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 05:12:14 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:8606 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbYLTKMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 05:12:12 -0500
Received: by qw-out-2122.google.com with SMTP id 3so487945qwe.37
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 02:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iYIh4ytydZkgHJMx2uYs+YPragMmkmgUugAsVP5DTGI=;
        b=NxmHaPoqaoa66PA1rYhZtL1IZsN/ZZPkPOLY7Qd6kJn+13fUuKZ2duP/TsbEM8o152
         LQDWusnIXsNyqY+6jlNWZKgfMlVHaKcFIk+e8LdgWjpNZqds8dpIefWMHRfBJsn5Aq7y
         yBaxCPJ3hhHT0sUk5KqHIy84y+HzQHlB/EeBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U7vwIuk4dtfYhSke1SzcMIPoPRYlSGIWD/CyYlIJ2v+cd2jymefp5Qxi7eq2RivRqV
         Z2pyvf8Oku7BfvSkwxJ9xwSh5PDin120LlZlbTWtouG89bUdvh9z/maML2V8nzKblxRL
         6zPO+qCori4GQ0ITi97CVKVgbMycp4cjhRyNU=
Received: by 10.214.60.5 with SMTP id i5mr4938962qaa.168.1229767931218;
        Sat, 20 Dec 2008 02:12:11 -0800 (PST)
Received: by 10.214.241.11 with HTTP; Sat, 20 Dec 2008 02:12:11 -0800 (PST)
In-Reply-To: <20081220081511.GA28212@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103635>

2008/12/20 Mike Hommey <mh@glandium.org>:
> On Wed, Dec 17, 2008 at 07:20:59PM -0800, Junio C Hamano wrote:
>> Markus Heidelberg <markus.heidelberg@web.de> writes:
>>
>> > in the "Merging external work" section of the gitcore-tutorial it is
>> > stated that the rsync transport is deprecated. The description was added
>> > in commit 914328a (Update tutorial., 2005-08-30) together with the
>> > "deprecated" note. Having never heard/read this before and since this
>> > commit is quite old, I wonder if it is still the case or there was a
>> > solution for this problem.
>>
>> Sorry, I do not quite understand what you perceive as "this problem".
>>
>> It has been deprecated for too long a time.  Maybe it is time to remove
>> the support, instead of carrying the deprecated command forever?  Is that
>> the problem you are talking about?
>>
>> I tend to agree that rsync transport way outlived its usefulness, and not
>> maintained at all.  There may be unnoticed and undiagnosed bugs lurking,
>> but nobody knows about it because nobody uses it.
>
> Something that could well make this transport be maintained would be to
> make it share code/internal API with the "local file transport".
> Ideally, http, rsync and file could all share the same basis, and
> ensuring the file transport to be functional would pretty much guarantee
> all work.

Just for the record: cloning via rsync is broken currently. I reported
this actually only shortly before Junio made this comment. Apparently
the code to copy across HEAD is missing from the rsync code, although
it is present for HTTP code.

Is there a bug tracking tool that git uses? I asked on #git on irc and
they said to just mail the list, but ive not seen any response to my
mail at all and the timing of Junios comment makes me wonder if my
report was seen by list regulars at all.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
