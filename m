From: Ping Yin <pkufranky@gmail.com>
Subject: Re: A question about using 'add -p' to split the patch
Date: Mon, 15 Jun 2009 14:24:39 +0800
Message-ID: <46dff0320906142324i191e50d5v1e89ba6311377a47@mail.gmail.com>
References: <46dff0320906142008v4f278d3ek3eebfa36f7fcf06a@mail.gmail.com>
	 <20090615061211.GA53136@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 08:30:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG5iO-0005Y4-Hh
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 08:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbZFOGag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 02:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbZFOGaf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 02:30:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:35184 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbZFOGaf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 02:30:35 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2431983ywb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5wc3ptFB9bEAEGvhR6uThGbOk+aE289O+A600/uktXU=;
        b=Z3eCJbxdMO6s8ZgjTz2lPP/dRISTSh/TDck6+ph9FoGW0xX/SW+67HiauJSJZopDxH
         bzW/jV9/G9kmJL2q1sqWvOj4N7eBl/eKKNO3s++f4WLngTWxgzO7SIFZT1j/o7xQjHrH
         KOtk7McP9UuTc/o18PwrWePR1tjZBMYc6E3nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FTw/Man0sSkYk36ddQiCedsEtO+sDnyfY36SoHQSw5r1iPueHONxj7Vanh4LtJ5FQh
         3B58z1mv01dOMa4gc8Krj7bKBHVKlzjc323jlhZ1k1XH5t/9rocgvbm9PzwkJZY+4qWr
         vj7L3m2x3BcHKijn182BEwVk543ktCJrI2AfY=
Received: by 10.90.35.9 with SMTP id i9mr1856569agi.58.1245047079350; Sun, 14 
	Jun 2009 23:24:39 -0700 (PDT)
In-Reply-To: <20090615061211.GA53136@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121586>

On Mon, Jun 15, 2009 at 2:12 PM, David Aguilar<davvid@gmail.com> wrote:
> On Mon, Jun 15, 2009 at 11:08:51AM +0800, Ping Yin wrote:
>> file bt.php in the HEAD:
>>
>> function bt_add($path) {
>> =C2=A0return;
>> }
>>
>> file bt.php in the working directory:
>>
>> function bt_move($path, $pos) {
>> =C2=A0 return;
>> }
>> function bt_add($path, $pos) {
>> =C2=A0 bt_move($path, $pos)
>> =C2=A0 return;
>> }
>>
>> Now i want to split the change into two parts:
>> First introduce bt_move
>> Then add a param pos to bt_add and call bt_move
>>
>> With the 'e' action of 'add -p', i got
>>
>> -function bt_add($path) {
>> +function bt_move($path, $pos) {
>> + =C2=A0return;
>> +}
>> +function bt_add($path, $pos) {
>> + =C2=A0bt_move($path, $pos)
>> =C2=A0 =C2=A0return;
>> =C2=A0}
>>
>> Then, i want to edit the patch to get
>>
>>
>> function bt_move($path, $pos) {
>> =C2=A0 return;
>> }
>> function bt_add($path) {
>> =C2=A0 return;
>> }
>>
>> However, whatever i do, the patch fails to apply. Any suggestion?
>
> Use git-gui or git-cola to select just bt_move() for addition.
> You can stage specific lines.

Doesn't the 'e' action of 'add -p' do the same job with git-gui?
