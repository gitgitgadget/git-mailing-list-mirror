From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [JGIT] Request for help
Date: Thu, 3 Sep 2009 11:38:47 -0400
Message-ID: <2c6b72b30909030838q10b88705gb8c553f2c2d74379@mail.gmail.com>
References: <4A9EFFB1.9090501@codeaurora.org> <alpine.DEB.1.00.0909030157090.8306@pacific.mpi-cbg.de> 
	<20090903012207.GF1033@spearce.org> <2c6b72b30909030545y4465b5c8j4b2b5587a07762c0@mail.gmail.com> 
	<20090903144227.GH1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nasser Grainawi <nasser@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 17:39:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjEP9-00067n-CD
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 17:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755815AbZICPjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 11:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755800AbZICPjH
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 11:39:07 -0400
Received: from mail-iw0-f175.google.com ([209.85.223.175]:45271 "EHLO
	mail-iw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZICPjG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 11:39:06 -0400
Received: by iwn5 with SMTP id 5so11887iwn.4
        for <git@vger.kernel.org>; Thu, 03 Sep 2009 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ZXCoL/7N9wgwPDHw+IkVmPx75QJ+zzsWxjZc2Khy2m8=;
        b=Ih+aX7nTzLnobE0b9T+aU69GZJR/vq384eFuRiFHDMitQu6+ksGl6HxXtr0OPhwThr
         Rzg/0NERHTKAmBwMVrUTM02dXl2rPmvYNv7SsazyOzmsTLdAUnrdLcGixb50t56/JBQ9
         dbFAaZKDTrVR4ngVNiH9j0vf9FuPBZgfoaoSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=L6NO+k5CoF9u32/ZmpPwc4K8T0Ks4EmXKjn9ApY0AnXNMqm6cTraAtxd6sJ41qAf3w
         gHtQ1ZFVYf8PojDSs7PdKkXP0KIcpBi6dhPwsjBTHcsCgf0L5jFVg2wcxoiAMGrGCXWl
         YhpcMRQm7kkvD4e3yRmAYs9SiNoMDHDEgBI8E=
Received: by 10.231.5.90 with SMTP id 26mr9244370ibu.42.1251992348063; Thu, 03 
	Sep 2009 08:39:08 -0700 (PDT)
In-Reply-To: <20090903144227.GH1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127657>

On Thu, Sep 3, 2009 at 10:42, Shawn O. Pearce<spearce@spearce.org> wrote:
> Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
>> BTW, what is your opinion of making it a bit easier to import and use
>> the Maven configuration by putting a pom.xml in the top-level
>> directory? The actual pom.xml file responsible for building the jgit
>> library can still live on in jgit-maven/ if that is preferable.
>>
>> I am also thinking about "mavenizing" the .pgm subproject to make it
>> easier to browse and search the code from within NetBeans.
>
> Actually, now that we have forked out of the egit.git repository,
> I want to refactor the layout of the JGit project to be more maven
> like, and have a proper top-level pom to build things.

What kind of module structure do you have in mind? Do you want to move
some of the modules/subdirectories?
Some refactoring of the maven setup for JGit back was done back in
April in sonatype's (a maven company) JGit clone. It is not
signed-off, but can serve as a reference.

 - http://github.com/sonatype/JGit/commit/641ae523c496f381a7673f4acfa0acdff9d3913e

The Maven layout in the sonatype clone simply uses the Eclipse project layout.

pom.xml: JGit :: Parent
 |- org.spearce.jgit/pom.xml: JGit :: Core
 |- org.spearce.jgit.pgm/pom.xml: JGit :: Programs
 `- org.spearce.jgit.test/pom.xml: JGit :: Test

However, having tests in a separate module can be both good/bad. For
example, they will not automatically get run when you only build the
Core module.

Anyway, I would like to help.

-- 
Jonas Fonseca
