From: Jensen Somers <jensen.somers@gmail.com>
Subject: How to migrate folders using svn:externals exclusively (no actual 
	data inside folder) to git submodules?
Date: Fri, 14 May 2010 20:53:18 +0200
Message-ID: <AANLkTikJNSPKPDdpYEYVJogPq22LyOr0s3QxEF7wZO1Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 20:53:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD012-000067-Fq
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 20:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758477Ab0ENSxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 14:53:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51684 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976Ab0ENSxj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 14:53:39 -0400
Received: by fxm6 with SMTP id 6so1825371fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=V3HKJOhDasQ/QDDUSUyI68cTz+FFknqFQEMkVINxc1w=;
        b=k7YR0aagODPxQGVNJVLWALZ7TNGxtf2AjMOsZj4IBMLGoKgAh5j4sMJzKHE5677l1H
         TxMOCaiOpZREeUkGe21oZbU3ZpxJMCGO2NFZJTuFffp78nn6SJTAjXXCDX9k2NW6g0wY
         +novRcnHHrhwaRAGDYsOTkoV/nQsXpJSsDwBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=FJzDvoGO7BsXdQcA8+fs63eM+6dlMeHkNXPTVVI4kSlhCLcx4zoC1ECPbXkyc9dr1p
         XG6TkHyE3i+UXN3sJsQ/X48VfvGvgUAJ6/Gk5TsrAOK14wahEE9MqNOqRXybu5RHHeWG
         j2Pi3TKPyYrJ3hB5ruVYK2wDv1D/16MP8c7h8=
Received: by 10.204.141.69 with SMTP id l5mr32819bku.64.1273863218138; Fri, 14 
	May 2010 11:53:38 -0700 (PDT)
Received: by 10.204.60.1 with HTTP; Fri, 14 May 2010 11:53:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147112>

Hello,

Having used Git a couple of times on some open source projects I am
beginning to be more and more convinced of the power and benefit it
has over subversion. One of the major benefits for me is the
possibility to create local branches - and thus work on several things
at the same time - without interfering with the actual master
repository or to have 10 different /trunk folders on my hard drive.

Where I work we currently use subversion but I am looking into
migrating everything to Git. There is one thing that is not very clear
to me though and I hope somebody could shine some light on the matter.

Our current repository is set up as follows:
/
+ /Modules
+ + /ModuleA
+ + /ModuleB
+ + /ModuleC
+ /Applications
+ + /ApplicationA
+ + /ApplicationB
+ /Views
+ + /ViewApplicationA
+ + /ViewApplicationB

ViewApplicationA and ViewApplicationB are empty folders which use the
svn:externals property to include all required folders. For
ViewApplicationA this would for example be ApplicationA, ModuleA and
ModuleC, for ViewApplicationB this would be ApplicationB, ModuleB and
ModuleC. Using the views the developers are able to checkout only
what's needed for the given project they work on.
And this is where Git confuses me. As an alternative for svn:externals
I stumbled upon Git submodules but I am not entirely sure they allow
me to do the same thing. Can I create a sub folder on my root Git
repository and let developers check out only that folder or do I need
to create a separate repository per view and reference another
repository (holding all actual data) as a submodule? And can I
actually do that on the server? Most examples I found talk about
cloning another repository as a submodule, but all of them seem to do
it locally, and not on the server and I don't want to bother every
developer doing all that every time he decides to start fresh.

Any tips, pointers, links to websites and other help to clarify this
is greatly appreciated.

- Jensen
