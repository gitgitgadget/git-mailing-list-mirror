From: E R <pc88mxer@gmail.com>
Subject: Re: integrating make and git
Date: Wed, 15 Apr 2009 11:47:52 -0500
Message-ID: <3a69fa7c0904150947w25783199n6e304d7b4efcd051@mail.gmail.com>
References: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
	 <alpine.LNX.1.00.0904151148030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 18:50:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu8Ii-0007aC-VY
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbZDOQrz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 12:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbZDOQry
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:47:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:18066 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbZDOQry convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2009 12:47:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3171666rvb.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=hmx27efiJV/tp1gb4Gi3vrZTLUyQlU5x07+5RJHQXvc=;
        b=T1NKUhI2l3vAV/gwEur10O+T6iMUIAQLAk0SWf9JPN//d7VIIECEqq1HKwtQP7iEGo
         S07VhIjjQdLCMmFbF/aHMQHX5MCqkKky8INUd8aJ7GYzUS2gRGow7s7VDNkolAF9GS3P
         ebDTztOPpQswaNSfaJyb9Wg3affCBqNAOPspc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=awonq8nYygN/LobcG1JlGMotJmvzW7aSnq4L9mGpRxvrOe+rc3FyhsVW8mEW0mDDWm
         4wd5b4IPWYHyHsIJNPK1ggKMazfkzCUdYSwcM4Y3EPj/Qbe6zTMN8BxGTE/AGuNu7aHE
         7AX4qAtKeiOEGRF7tQbU9+dirFq8TenUOi5R4=
Received: by 10.220.45.211 with SMTP id g19mr90537vcf.86.1239814072786; Wed, 
	15 Apr 2009 09:47:52 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0904151148030.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116626>

Ok - I was wrong about the timestamps not getting updated. Thanks for
that correction.

However, what about the idea of associating the result of a build with
the hash of the source files used by the build, and using git to
compute the hash?

On Wed, Apr 15, 2009 at 11:20 AM, Daniel Barkalow <barkalow@iabervon.or=
g> wrote:
> On Wed, 15 Apr 2009, E R wrote:
>
>> I have an idea about integrating make with git, and I'm wondering if
>> it is a reasonable thing to do.
>>
>> First of all, I am under the impression that git can quickly compute=
 a
>> hash of a directory and its contents. Is that correct?
>>
>> If so, suppose you using git to manage revision control of a project
>> which has some components like 'lib1', 'lib2', etc. Typically you
>> would perform something like: make clean; make all and 'make all'
>> would perform 'make lib1' and 'make lib2'. When checking out a
>> different revision of the project you would have to perform another
>> 'make clean' before 'make all' since you aren't sure of what's chang=
ed
>> and the timestamps of the derived files will be more recent than the
>> timestamps of the source files.
>
> No, the timestamps of the changed source files will be newer than the
> timestamps of the derived files. Git doesn't backdate files in workin=
g
> directories, in order to avoid causing the problem you're trying to f=
ix.
> (And because getting the history is so quick and easy with git that
> looking at dates on files in the filesystem is kind of pointless.)
>
> =A0 =A0 =A0 =A0-Daniel
> *This .sig left intentionally blank*
>
