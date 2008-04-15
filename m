From: "Scott Collins" <scc@scottcollins.net>
Subject: Re: [PATCH] Clarify documentation of git-cvsserver, particularly in relation to git-shell
Date: Tue, 15 Apr 2008 15:33:44 -0400
Message-ID: <39292ba40804151233k2dd9300as5611e65ab6fcd81d@mail.gmail.com>
References: <1208273402-2152-1-git-send-email-scc@ScottCollins.net>
	 <7vve2jx9at.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 21:35:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlqvU-0005Eu-Nn
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 21:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbYDOTeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 15:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbYDOTeA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 15:34:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:6480 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417AbYDOTd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 15:33:59 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1095024ywb.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Bi3ilFcjRSviL2NA/qjEk3s0hMwXUpKfb+AeRHqIVEE=;
        b=qnPDwonqi/QG59YCiFtX9N6CMztAiPiVBg6eE3v69mRFJDK0xPgHbciCtRIy5/2YELkSTfv7yuM7JjSfto6zkAh+PyrxbU3XtCua9YrDFmbfYgYitRLPTkuqYf7xyH9EaotvXz4qqgmlXmGa/xUDwJyTJEJ16PaS+EuOlDsXjoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pv1jLQvl67HsGFLDrRIKGPB0/1i0KPPCvyw0pos8cbD1APxdkq4EK0Wn2fC6SQjwt3RS/1g+BbcHqJHlJi8XoyiTbHP5fOErPJ2HFpm11cfbpZBi3lxKpUx/7IFW3bj9evMq3FixpXB9siyr47OjG2sfy912lawfHtXPfx8kYRI=
Received: by 10.151.150.13 with SMTP id c13mr8295413ybo.173.1208288024082;
        Tue, 15 Apr 2008 12:33:44 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Tue, 15 Apr 2008 12:33:44 -0700 (PDT)
In-Reply-To: <7vve2jx9at.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 86fad546f6cd39b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79624>

On Tue, Apr 15, 2008 at 2:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Thanks; please make it a habit to give a final round of proofreading
>  before you send your messages out.  For example, I do not think we meant
>  "GIT_AUTHOR_(NAME|COMMITTER)" ;-)

Yikes!  Correct.

>  Hmm.  Can't this be further improved?
>
>  My undestanding of the reasoning behind 0c696fe (Support cvs via
>  git-shell, 2007-10-09) is by doing this people do not have to say
>  CVS_SERVER and do this instead:
>
>         cvs -d :ext:[user@]cvs.example.com:/path/to/repo checkout foo
>
>  which would truly hide the fact that the server end is running something
>  funky, because the command line exactly matches how you would access the
>  real CVS repository over ssh.

If that's the case, then I should mention instead that users
restricted to git-shell should _not_ set or change CVS_SERVER, and
remove the extra examples.

>  Dscho, care to comment?  This commit happened while I was away so I do not
>  really _recall_ the discussion that led to it, but I have always thought
>  that was the intention.

I actually was very tempted to modify git-shell to understand
git-cvsserver; but decided to submit a documentation patch first,
hoping from the discussion I would learn if that was the right path.


>  >  5. Clients should now be able to check out the project. Use the CVS 'module'
>  > -   name to indicate what GIT 'head' you want to check out. Example:
>  > +   name to indicate what GIT 'head' you want to check out.  This also sets the
>  > +   name of your newly checked-out directory, unless you tell it otherwise with
>  > +   `-d <dir_name>` Example:
>  >  +
>  >  ------
>  > -     cvs co -d project-master master
>  > +     cvs co master -d project-master
>  >  ------
>
>  Are you sure you wanted to do this?  In any case this is different from
>  what I read you changed in your commit log message, where you clarified
>  distinction between d1 and d2 in "cvs -d d1 co -d d2 module".  Instead
>  what you did here is to change "cvs co -d d module" (which looks more
>  natural) to "cvs co module -d d" (which might work if the options are
>  reordered across parameters, but is unusual).

Hmmm.  My intent was to make it read more naturally, which for me is
"checkout this module, put it into this directory".  At least that's
how I've always said it to CVS.  Warning readers that there are two
different meanings for -d, and they probably want them both in the
same command is more important to me than moving the -d to the end.  A
better fix to that example would be something along the lines of:

  cvs -d <CVSROOT-as-above> co -d <dir-name> <head-name>

I didn't do that, though, because it looked like this example was
intended to be concrete.

I'll update my patch and re-submit after I test not setting
CVS_SERVER, and feel I have the right replacement example, if any, for
the text just above.
__________
Scott Collins
