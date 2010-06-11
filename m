From: PJ Hyett <pjhyett@gmail.com>
Subject: Re: Git sideband hook output
Date: Fri, 11 Jun 2010 07:34:07 -0700
Message-ID: <AANLkTikYBB1DsGRRsu4pSNr1j8fFXD-99c4lRAaBqd3M@mail.gmail.com>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
	<20100608214632.GN14847@spearce.org>
	<A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
	<alpine.LFD.2.00.1006090934320.30664@xanadu.home>
	<A612847CFE53224C91B23E3A5B48BAC744839BF6AE@xmail3.se.axis.com>
	<20100610183019.GR14847@spearce.org>
	<AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 16:34:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON5JJ-00075Q-DA
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 16:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760299Ab0FKOeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 10:34:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51603 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760191Ab0FKOeI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jun 2010 10:34:08 -0400
Received: by pwi1 with SMTP id 1so500125pwi.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U1x9cBtMCcn1TxyDAkyB/fWeRJLVROchfNQtSP0+1I8=;
        b=JzJN/uP3jSTcLbmYm3xCetcWec07lGYMGw2lkl+zMfO1OLmOBrC9SPZNlZ3ssZNMkf
         nYq/5RmCIUtgl88nolLck9I2HS3qGMiFv7eM2B1aC3uqvm8/z4DTyOQOhsdw/AbK02lp
         u1pa072SzKzdFKNVrx69IPBAfyfTcACi0bw1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bKTc23670sCT30VvO7sNHe4dyLsLrjehLPFYL5lVGK+RDZIH6Y8dw8F3WX156ht1OO
         RC4J3GMdBJAfIKiZ6EEHnS1O6ZC98Nh9fp++8/3AK/SOpi15vpq4P/TRk1uTzOKlsOlB
         UtEPzr0aVb5LYXAL2tdIIOG9lp4sb6Jo2v/Ek=
Received: by 10.142.247.24 with SMTP id u24mr1385130wfh.313.1276266847721; 
	Fri, 11 Jun 2010 07:34:07 -0700 (PDT)
Received: by 10.142.136.18 with HTTP; Fri, 11 Jun 2010 07:34:07 -0700 (PDT)
In-Reply-To: <AANLkTikQQh4sUA7h2k1jvQ7aMgYyq7WFetJvJZvqpVxt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148949>

Hi,

> On Thu, Jun 10, 2010 at 8:30 PM, Shawn O. Pearce <spearce@spearce.org=
> wrote:
>>
>> If its really a problem, maybe "remote: " prefix should turn into
>> something shorter and language agnostic, like "<< ". =A0But thus far
>> we hadn't had to worry about it, since we didn't have translation
>> support in Git... =A0(though yes, I see that is changing now).
>>

I'm also in favor of making the default '>>' instead of 'remote:' if
nothing isn't an option.

Using Heroku as an example, this is what their current hook output look=
s like:

$ git push origin master
Counting objects: 9, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 684 bytes, done.
Total 5 (delta 2), reused 0 (delta 0)

-----> Heroku receiving push
-----> Sinatra app detected
       Compiled slug size is 3.9MB
-----> Launching....... done
       http://fi-quote.heroku.com deployed to Heroku

To git@heroku.com:fi-quote.git
   0bb7fa2..2755742  master -> master


Now, if you compare that to what it would look like if they were
running a more recent version of git, the verboseness of remote: is
quite apparent:


$ git push origin master
Counting objects: 9, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 684 bytes, done.
Total 5 (delta 2), reused 0 (delta 0)
remote:
remote: -----> Heroku receiving push
remote: -----> Sinatra app detected
remote:       Compiled slug size is 3.9MB
remote: -----> Launching....... done
remote:       http://fi-quote.heroku.com deployed to Heroku
remote:
To git@heroku.com:fi-quote.git
   0bb7fa2..2755742  master -> master

In a perfect world, I think it should be up to the user to determine
the amount of information they receive (using a verbose switch
perhaps), but short of that, at least toning down what is output would
be much appreciated.

Cheers,
PJ
