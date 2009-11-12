From: Matt Schoen <mtschoen@gmail.com>
Subject: Re: get git not to care about permissions
Date: Thu, 12 Nov 2009 10:44:50 -0500
Message-ID: <3cf217d80911120744g5e020003rc00c460fff0bff1d@mail.gmail.com>
References: <26268938.post@talk.nabble.com>
	 <76718490911112144n6837d02cw94d608bcbc74855a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:50:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8bwh-0007ok-9v
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbZKLPuT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 10:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZKLPuT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:50:19 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:33536 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbZKLPuR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 10:50:17 -0500
Received: by ywh40 with SMTP id 40so387874ywh.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 07:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f8i4TueO5HHfU4Pr2OnHZEVBtFTEvbWmM2fhOWjb7DE=;
        b=uvUnldpJup4t7BGWLaACBJss4CxPy1bImOhZmvc/bamphEcwOs1ydalTeb3tgbAVyZ
         NuxE2hrfRp/O0Tncovepqr2FlsY5JdYLgZoE6UzgXLUrfb2mqyEmweTIPi4CYUmf0FtO
         RRQ/lMIxfjMZtZZo+v/IMX3v05neyy+DxqjCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vwl2sEm0szXQ1xqgS53WpJ3kPfJDsvOZyyW/4rNqmjTnr8lzDKN4ZdB4StwL2y+G1w
         BJPySMTK0vefTPOCPo4cJlzT14ZnWjr4FVeXxildMscOEcuos5mmNSHexdvIqssG1kvx
         1jeIP02cQjEQM+TPKOpzoOpCQjGb++OsjDLBE=
Received: by 10.101.171.36 with SMTP id y36mr1826081ano.75.1258040690960; Thu, 
	12 Nov 2009 07:44:50 -0800 (PST)
In-Reply-To: <76718490911112144n6837d02cw94d608bcbc74855a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132778>

The only output I get is:

warning: templates not found /tmp/git/share/git-core/templates
error: Unable to open
/ad/eng/courses/ec/ec464/ec464-team03/test.git/HEAD.lock for writing

ls -al in the directory gives me:
total 12
drwx------ 3 schoen root 4096 Nov 12 10:41 .
d--------- 7 root   root 4096 Nov 12 10:41 ..
-rwx------ 1 schoen root    0 Nov 12 10:41 HEAD.lock
drwx------ 4 schoen root 4096 Nov 12 10:41 refs

As I understand it, because we use Kerberos, permissions on everything
must be set to 700 at most.  I think the issue here comes from the
fact that git wants to use group permissions.  This is my guess.

On Thu, Nov 12, 2009 at 12:44 AM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> On Wed, Nov 11, 2009 at 4:17 PM, sconeman <schoen@bu.edu> wrote:
>> does. =A0Git doesn't like this and won't even create a bare reposito=
ry. =A0Is
>> there any way I can get git to ignore permissions and just do what i=
t needs
>> to do?
>
> And the output from "git init --bare" is?
>
> j.
>
>
