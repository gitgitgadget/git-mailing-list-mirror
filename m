From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 08:07:27 +0100
Message-ID: <320075ff0804170007k5171eb72n68882679f62fa238@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
	 <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
	 <20080416203923.GH3133@dpotapov.dyndns.org>
	 <320075ff0804161447u25dfbb2bmcd36ea507224d835@mail.gmail.com>
	 <20080416223739.GJ3133@dpotapov.dyndns.org>
	 <320075ff0804161607p3f9e983ehb75aae4e0bfe8837@mail.gmail.com>
	 <20080417004645.GK3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 09:08:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmOEK-0007lA-41
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 09:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbYDQHHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 03:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbYDQHHd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 03:07:33 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:53995 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbYDQHH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 03:07:29 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3206272fkr.5
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KEVVXRqfOBDmFXbVvm5cjn33VgIvBMpM2gEvDOTQhUI=;
        b=WGB/QspbLKSjGAt9y3mJkxi1DBYLspQ0ZcoEPCY1AYVQmE7lRCCwS50FuiW67qRDblHr5Ou58+bH/JKzph+wHBkoctDsf4DKJ6zJSrtp4XqU/pHXqJbqU4aDkSdcMX79b+lLFw+KUo0MwUbCCF7VDKS200AIaPfCrXw4VLu/5Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aLIXu1CtY5d4Hr8D4OQ2MffnQ10V2ZbX3A0xDi6PvtdbFFDcSwWh5SqiMjn70s8qGStMITRtkWHtCijSoMz3bFxgLmtxsPDS0qP6DPSvIlcM0UriVFqdqAj+f5ONy52PLMvfIVg1tdQNq3VnRM1Pur9/WiEgRZ/6SCGjOWUW+HU=
Received: by 10.82.119.17 with SMTP id r17mr1628684buc.56.1208416047634;
        Thu, 17 Apr 2008 00:07:27 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Thu, 17 Apr 2008 00:07:27 -0700 (PDT)
In-Reply-To: <20080417004645.GK3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79771>

On Thu, Apr 17, 2008 at 1:46 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Thu, Apr 17, 2008 at 12:07:27AM +0100, Nigel Magnay wrote:
>  > >  > The bit I really don't understand is why git thinks a file that has
>  > >  > just been touched has chnaged when it hasn't,
>  > >
>  > >  Actually, it did change in the sense that if you try to commit this
>  > >  file now into the repository, you will have a different file in Git!
>  > >  So, it is more correct to say that Git did not notice this change until
>  > >  you touch this file, because this change is indirect (autocrlf causes
>  > >  a different interpretation of the file).
>  > >
>  >
>  > Okay - at the very least this behaviour is really, really confusing.
>  > And I think there's actually a bug (it should *always* report that the
>  > file is different), not magically after it's been touched.
>
>  I don't think there is a simple way to correct that without penalizing
>  normal use cases. Usually, people do not change autocrlf during their
>  normal work. Besides, you can have your own input filters and they may
>  cause the same effect. So, Git works in the assumption that input filters
>  always produce the same results...

This has nothing to do with changing core.autocrlf after checkout -
it's a problem with *any* repo with CRLF files, being checked out on a
core.autocrlf=true machine, which basically is any windows machine.

The current 'isDirty' check seems to be something like

isDirty = ( wc.file.mtime > someValue ) && ( repository.file !=
filter(wc.file) )

I'm saying it ought to be something like

isDirty = ( wc.file.mtime > someValue ) && (sha1(repository.file) !=
sha1(wc.file) ) && ( repository.file != filter(wc.file) )


>
>
>  >
>  > But fixing that minor bug still leads to badness for the user. Doing
>  > (on a core.autocrlf=true machine) a checkout of any revision
>  > containing a file that is (currently) CRLF in the repository, and your
>  > WC is *immediately* dirty. However technically correct that is, it
>  > doesn't fit most people's user model of an SCM, because they haven't
>  > made any modification.
>
>  IMHO, the only sane way is never store CRLF in the Git repository.
>  You can have whatever ending you like in your work tree, but inside
>  of Git, LF is the actually marker of the end-of-line.
>

Great. I'll go and argue with the team using svn, who don't even
*notice* this issue, and try to get them to adjust the metadata on
every single file in the repository.

Then, for a bonus, I'll try the same with every OSS project that I'm
tracking with git-svn. :-(

I get that things are horribly broken if you get CRLF in your
repository. But it's unreasonable to expect the ability to bend the
rest of the world to what's convenient for me! Some of our windows
coders probably even *like* svn:eol-style=CRLF !

>
>  > And if 1 person makes a change along with their
>  > conversion, and the other 'just' does a CRLF->LF conversion,
>
>  If you imported correctly in Git, it should not have CRLF for text
>  files. So, there is no conversion that a user does expliciltly.
>
>
>  > And because the svn is
>  > mastered crlf (well, strictly speaking, it's ignorant of line endings)
>  > this is gonna happen a lot.
>
>  Not really. SVN has its own setting for EOL conversion. If you have
>  'svn:eol-style' set to 'native' for any text file then SVN will
>  checkout text files accordingly to your native EOL (you can specify
>  your native EOL using the --native-eol option when it is necessary).
>

Can I set this personally, without affecting the svn repo? If so, why
isn't git-svn doing this anyway, and can I tell it to do so?

>
>  > Can't git be taught that if the WC is byte-identical to the revision
>  > in the repository (regardless of autocrlf) then that ought not to be
>  > regarded as a change?
>
>  Why should not it? If a file is different as long as Git repository is
>  concern then then it *is* a change. Git binary compare files _after_
>  applying all specified filters (and you can have your own filters, not
>  only autocrlf).
>

See above. Unchanged (on disk, byte identical) files, if touched, get
(sometimes) marked as dirty.

>
>  > Is there a way I can persuade the diff / merge mechanisms to normalise
>  > before they operate? (e.g if core.autocrlf does lf->crlf/crlf->lf,
>  > then an equivalent that does crlf->lf/crlf->lf before doing the merge
>  > )?
>
>  I am not sure if there is a standard option for that, but it is
>  certainly possible to define your own merge strategy.
>
Ok - I'll have a look into this - just a filter on each file before
merging would be sufficient. Presumably people that do things like
$Id$ expansion need something similar to avoid constant merge
conflicts..

>
>  >
>  > In a perfect world I'd be able to switch all files int he repo to LF,
>  > but that's not going to happen any time soon because of the majority
>  > of developers, still on svn, still on windows.
>
>  Well, I don't see any problem here if everything is configured properly.
>  How files are stored inside and what you have in your work tree does
>  not have to be the same. So, storing everything inside with LF is
>  certainly possible. Actually, I believe it is exactly what CVS does
>  (unless you added a file with '-kb'), and people use CVS on Windows.
>  Importing files with CRLF in Git, it is like putting files as _binary_
>  in CVS.
>
>  Dmitry
>
