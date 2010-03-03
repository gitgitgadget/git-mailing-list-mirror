From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Which VCS besides git?
Date: Wed, 3 Mar 2010 13:58:41 +0200
Message-ID: <94a0d4531003030358q276a8e9bue086a8ec06aba395@mail.gmail.com>
References: <201003021455.52483.karlis.repsons@gmail.com>
	 <m3y6ialn3z.fsf@localhost.localdomain>
	 <201003021622.22196.karlis.repsons@gmail.com>
	 <201003030241.16959.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>,
	git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 12:58:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmnE0-00027J-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 12:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab0CCL6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Mar 2010 06:58:44 -0500
Received: from mail-iw0-f196.google.com ([209.85.223.196]:51212 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab0CCL6m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 06:58:42 -0500
Received: by iwn34 with SMTP id 34so1229731iwn.15
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dlvhX1hyFitqe0USmTwptyzVVCufyFAoLGo4MGJ1c98=;
        b=cU9usr790bUTtUduhuyd7WzGdfukxwA2DMUyPDFqQK9mY2J7JMp0eMhPKpuomW3S3Q
         qwU6goj/FSn6QChJyA8JsX1MQTXSjLydMb0np2ojljB72oUUK2V1Kh/HH7jdITqyR9by
         i6lKGE5hvO9eKhEXDt27GAwe78OJfuFDeDYms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bfZz7sQp9X/DPfZbSrvCIkdqN2CjbXx96XkvaEcL7aBPExIFA6aeY2Yf0MTx8uckEh
         QMi3H9b91AkXv9pZbzl636G9NSfzq42ScntS3t3Q4ouWYVuDVM1jfOneLaZxOEpoyvaj
         FaWVAi5VjINDc3JJewBAJaGZIxqxMYr8x07AI=
Received: by 10.231.147.199 with SMTP id m7mr745336ibv.87.1267617522244; Wed, 
	03 Mar 2010 03:58:42 -0800 (PST)
In-Reply-To: <201003030241.16959.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141446>

On Wed, Mar 3, 2010 at 3:41 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> K=C4=81rlis Repsons wrote:
>> On Tuesday 02 March 2010 16:12:22 Jakub Narebski wrote:
>> > K=C4=81rlis Repsons <karlis.repsons@gmail.com> writes:
>
>> > > which VCS besides git provide chaining of commits with help of s=
ome
>> > > cryptographic hash function, warning about or not allowing commi=
ts to be
>> > > deleted on an equivalent of pull action, so that all added piece=
s of data
>> > > can be retained securely on client side?
>> >
>> > Could you rephrase your request in more clear way?
>>
>> On top of what you wrote already, I'd like to know which VCS have im=
mutable
>> history, which can all be stored (say, gradually accumulated) on cli=
entside? I
>> hope, that explained the idea...
>
> As I wrote, all VCS which use cryptographic hash function (digest) fo=
r
> commit identifier have immutable history.

That's not exactly correct. Monotone works very differently; a
revision doesn't include the ancestry, that's handled in a separate
structure, so the revision hash doesn't tell you anything about the
ancestry. In fact, a revision doesn't contain anything, the data is
handled by "certs", and certs can be added later.

=46or example, it's possible to clone a repository and then add a secon=
d
commit message to a bunch of revisions. The revision hash doesn't
change. Instead, they ensure security by signing every piece of data
about a commit (commit date, author, commit message). So it's possible
to have multiple commit dates, authors, messages, etc. each signed by
a different person.

I'm not really fond of this approach :P

--=20
=46elipe Contreras
