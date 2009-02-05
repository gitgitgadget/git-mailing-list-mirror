From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 05/11] Add new class SWTUtils with helper-methods for creating controls
Date: Thu,  5 Feb 2009 02:00:12 +0100
Message-ID: <1233795618-20249-6-git-send-email-torarnv@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
 <1233795618-20249-2-git-send-email-torarnv@gmail.com>
 <1233795618-20249-3-git-send-email-torarnv@gmail.com>
 <1233795618-20249-4-git-send-email-torarnv@gmail.com>
 <1233795618-20249-5-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:02:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUsdL-0000xt-Hw
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbZBEBAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 20:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbZBEBAN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 20:00:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:6769 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464AbZBEA7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:59:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1586fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WSRyAjCJIlorFdGm5Y9OIxsKJf2p4LyAg4xz8VRxkuU=;
        b=jjRca8nEqC/KDl0AUGSsEiz1S308cW4pOx81FNRFoNPvUwx/1hllGQWtlznrJ+8hjp
         26lh5xcC1JdipIK6Gd7FfpgP0SNZC9z5acXJ26PFI3TpqRgnEdAQ3CVRMX7RWvCV2nMG
         ihteV6SrxODByI64Vf755BoKnrrOuMqEVrjpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bT/lKJqHNTEaztv03BDVDSTUs52wjZYDiIZmamsc3uNLdL+UUweTzaj06XX0N5f2nK
         T8go4zQzoQkCrexk+5s+8CWe61hcytfv+qH/+9M65pR4KZ+vKm2YOaduJ2oIdf51u/DT
         thYCCmz7Tdo1G0zukdpaV+yeeKbUCjrxygksk=
Received: by 10.86.92.7 with SMTP id p7mr798155fgb.24.1233795591992;
        Wed, 04 Feb 2009 16:59:51 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 4sm26207fge.54.2009.02.04.16.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:51 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 9A09617800B; Thu,  5 Feb 2009 02:00:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1233795618-20249-5-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108486>

Copied verbatim from org.eclipse.team.internal.ui and documented

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../src/org/spearce/egit/ui/internal/SWTUtils.java |  595 ++++++++++++=
++++++++
 1 files changed, 595 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/SWTUtils.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/SWTUt=
ils.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/SWTUtil=
s.java
new file mode 100644
index 0000000..fe65bbb
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/SWTUtils.jav=
a
@@ -0,0 +1,595 @@
+/*********************************************************************=
**********
+ * Copyright (c) 2000, 2005 IBM Corporation and others.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *	 IBM Corporation - initial API and implementation
+ *********************************************************************=
**********/
+
+package org.spearce.egit.ui.internal;
+
+import org.eclipse.core.runtime.Assert;
+import org.eclipse.jface.dialogs.Dialog;
+import org.eclipse.jface.dialogs.IDialogConstants;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.graphics.FontMetrics;
+import org.eclipse.swt.graphics.GC;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.*;
+import org.eclipse.ui.dialogs.PreferenceLinkArea;
+import org.eclipse.ui.preferences.IWorkbenchPreferenceContainer;
+
+/**
+ * A collection of factory methods for creating common SWT controls
+ */
+public class SWTUtils {
+
+	/** */
+	public static final int MARGINS_DEFAULT =3D -1;
+
+	/** */
+	public static final int MARGINS_NONE =3D 0;
+
+	/** */
+	public static final int MARGINS_DIALOG =3D 1;
+
+	/**
+	 * Creates a preference link which will open in the specified contain=
er
+	 *=20
+	 * @param container
+	 * @param parent
+	 * @param pageId
+	 * @param text
+	 *=20
+	 * @return the created link
+	 */
+	public static PreferenceLinkArea createPreferenceLink(
+			IWorkbenchPreferenceContainer container, Composite parent,
+			String pageId, String text) {
+		final PreferenceLinkArea area =3D new PreferenceLinkArea(parent,
+				SWT.NONE, pageId, text, container, null);
+		return area;
+	}
+
+	/**
+	 * Creates a grid data with the specified metrics
+	 *=20
+	 * @param width
+	 * @param height
+	 * @param hFill
+	 * @param vFill
+	 *=20
+	 * @return the created grid data
+	 */
+	public static GridData createGridData(int width, int height, boolean =
hFill,
+			boolean vFill) {
+		return createGridData(width, height, hFill ? SWT.FILL : SWT.BEGINNIN=
G,
+				vFill ? SWT.FILL : SWT.CENTER, hFill, vFill);
+	}
+
+	/**
+	 * Creates a grid data with the specified metrics
+	 *=20
+	 * @param width
+	 * @param height
+	 * @param hAlign
+	 * @param vAlign
+	 * @param hGrab
+	 * @param vGrab
+	 *=20
+	 * @return the created grid data
+	 */
+	public static GridData createGridData(int width, int height, int hAli=
gn,
+			int vAlign, boolean hGrab, boolean vGrab) {
+		final GridData gd =3D new GridData(hAlign, vAlign, hGrab, vGrab);
+		gd.widthHint =3D width;
+		gd.heightHint =3D height;
+		return gd;
+	}
+
+	/**
+	 * Creates a horizontal grid data with the default metrics
+	 *=20
+	 * @return the created grid data
+	 */
+	public static GridData createHFillGridData() {
+		return createHFillGridData(1);
+	}
+
+	/**
+	 * Creates a horizontal grid data with the specified span
+	 *=20
+	 * @param span
+	 *=20
+	 * @return the created grid data
+	 */
+	public static GridData createHFillGridData(int span) {
+		final GridData gd =3D createGridData(0, SWT.DEFAULT, SWT.FILL,
+				SWT.CENTER, true, false);
+		gd.horizontalSpan =3D span;
+		return gd;
+	}
+
+	/**
+	 * Creates a horizontal fill composite with the specified margins
+	 *=20
+	 * @param parent
+	 * @param margins
+	 *=20
+	 * @return the created composite
+	 */
+	public static Composite createHFillComposite(Composite parent, int ma=
rgins) {
+		return createHFillComposite(parent, margins, 1);
+	}
+
+	/**
+	 * Creates a horizontal fill composite with the specified margins and
+	 * columns
+	 *=20
+	 * @param parent
+	 * @param margins
+	 * @param columns
+	 *=20
+	 * @return the created composite
+	 */
+	public static Composite createHFillComposite(Composite parent, int ma=
rgins,
+			int columns) {
+		final Composite composite =3D new Composite(parent, SWT.NONE);
+		composite.setFont(parent.getFont());
+		composite.setLayoutData(createHFillGridData());
+		composite.setLayout(createGridLayout(columns,
+				new PixelConverter(parent), margins));
+		return composite;
+	}
+
+	/**
+	 * Creates a horizontal/vertical fill composite with the specified ma=
rgins
+	 *=20
+	 * @param parent
+	 * @param margins
+	 *=20
+	 * @return the created composite
+	 */
+	public static Composite createHVFillComposite(Composite parent, int m=
argins) {
+		return createHVFillComposite(parent, margins, 1);
+	}
+
+	/**
+	 * Creates a horizontal/vertical fill composite with the specified ma=
rgins
+	 * and columns
+	 *=20
+	 * @param parent
+	 * @param margins
+	 * @param columns
+	 *=20
+	 * @return the created composite
+	 */
+	public static Composite createHVFillComposite(Composite parent,
+			int margins, int columns) {
+		final Composite composite =3D new Composite(parent, SWT.NONE);
+		composite.setFont(parent.getFont());
+		composite.setLayoutData(createHVFillGridData());
+		composite.setLayout(createGridLayout(columns,
+				new PixelConverter(parent), margins));
+		return composite;
+	}
+
+	/**
+	 * Creates a horizontal fill group with the specified text and margin=
s
+	 *=20
+	 * @param parent
+	 * @param text
+	 * @param margins
+	 * @return the created group
+	 */
+	public static Group createHFillGroup(Composite parent, String text,
+			int margins) {
+		return createHFillGroup(parent, text, margins, 1);
+	}
+
+	/**
+	 * Creates a horizontal fill group with the specified text, margins a=
nd rows
+	 *=20
+	 * @param parent
+	 * @param text
+	 * @param margins
+	 * @param rows
+	 *=20
+	 * @return the created group
+	 */
+	public static Group createHFillGroup(Composite parent, String text,
+			int margins, int rows) {
+		final Group group =3D new Group(parent, SWT.NONE);
+		group.setFont(parent.getFont());
+		group.setLayoutData(createHFillGridData());
+		if (text !=3D null)
+			group.setText(text);
+		group.setLayout(createGridLayout(rows, new PixelConverter(parent),
+				margins));
+		return group;
+	}
+
+	/**
+	 * Creates a horizontal/vertical fill group with the specified text a=
nd
+	 * margins
+	 *=20
+	 * @param parent
+	 * @param text
+	 * @param margins
+	 *=20
+	 * @return the created group
+	 */
+	public static Group createHVFillGroup(Composite parent, String text,
+			int margins) {
+		return createHVFillGroup(parent, text, margins, 1);
+	}
+
+	/**
+	 * Creates a horizontal/vertical fill group with the specified text, =
margins
+	 * and rows
+	 *=20
+	 * @param parent
+	 * @param text
+	 * @param margins
+	 * @param rows
+	 *=20
+	 * @return the created group
+	 */
+	public static Group createHVFillGroup(Composite parent, String text,
+			int margins, int rows) {
+		final Group group =3D new Group(parent, SWT.NONE);
+		group.setFont(parent.getFont());
+		group.setLayoutData(createHVFillGridData());
+		if (text !=3D null)
+			group.setText(text);
+		group.setLayout(createGridLayout(rows, new PixelConverter(parent),
+				margins));
+		return group;
+	}
+
+	/**
+	 * Creates a horizontal/vertical fill grid data with the default metr=
ics
+	 *=20
+	 * @return the created grid data
+	 */
+	public static GridData createHVFillGridData() {
+		return createHVFillGridData(1);
+	}
+
+	/**
+	 * Creates a horizontal/vertical fill grid data with the specified sp=
an
+	 *=20
+	 * @param span
+	 *=20
+	 * @return the created grid data
+	 */
+	public static GridData createHVFillGridData(int span) {
+		final GridData gd =3D createGridData(0, 0, true, true);
+		gd.horizontalSpan =3D span;
+		return gd;
+	}
+
+	/**
+	 * Creates a grid layout with the specified number of columns and the
+	 * standard spacings.
+	 *=20
+	 * @param numColumns
+	 *            the number of columns
+	 * @param converter
+	 *            the pixel converter
+	 * @param margins
+	 *            one of <code>MARGINS_DEFAULT</code>, <code>MARGINS_NONE=
</code>
+	 *            or <code>MARGINS_DIALOG</code>.
+	 *=20
+	 * @return the created grid layout
+	 */
+	public static GridLayout createGridLayout(int numColumns,
+			PixelConverter converter, int margins) {
+		Assert.isTrue(margins =3D=3D MARGINS_DEFAULT || margins =3D=3D MARGI=
NS_NONE
+				|| margins =3D=3D MARGINS_DIALOG);
+
+		final GridLayout layout =3D new GridLayout(numColumns, false);
+		layout.horizontalSpacing =3D converter
+				.convertHorizontalDLUsToPixels(IDialogConstants.HORIZONTAL_SPACING=
);
+		layout.verticalSpacing =3D converter
+				.convertVerticalDLUsToPixels(IDialogConstants.VERTICAL_SPACING);
+
+		switch (margins) {
+		case MARGINS_NONE:
+			layout.marginLeft =3D layout.marginRight =3D 0;
+			layout.marginTop =3D layout.marginBottom =3D 0;
+			break;
+		case MARGINS_DIALOG:
+			layout.marginLeft =3D layout.marginRight =3D converter
+					.convertHorizontalDLUsToPixels(IDialogConstants.HORIZONTAL_MARGIN=
);
+			layout.marginTop =3D layout.marginBottom =3D converter
+					.convertVerticalDLUsToPixels(IDialogConstants.VERTICAL_MARGIN);
+			break;
+		case MARGINS_DEFAULT:
+			layout.marginLeft =3D layout.marginRight =3D layout.marginWidth;
+			layout.marginTop =3D layout.marginBottom =3D layout.marginHeight;
+		}
+		layout.marginWidth =3D layout.marginHeight =3D 0;
+		return layout;
+	}
+
+	/**
+	 * Creates a label with the specified message
+	 *=20
+	 * @param parent
+	 * @param message
+	 *=20
+	 * @return the created label
+	 */
+	public static Label createLabel(Composite parent, String message) {
+		return createLabel(parent, message, 1);
+	}
+
+	/**
+	 * Creates a label with the specified message and span
+	 *=20
+	 * @param parent
+	 * @param message
+	 * @param span
+	 *=20
+	 * @return the created label
+	 */
+	public static Label createLabel(Composite parent, String message, int=
 span) {
+		final Label label =3D new Label(parent, SWT.WRAP);
+		if (message !=3D null)
+			label.setText(message);
+		label.setLayoutData(createHFillGridData(span));
+		return label;
+	}
+
+	/**
+	 * Creates a check box with the specified message
+	 *=20
+	 * @param parent
+	 * @param message
+	 *=20
+	 * @return the created check box
+	 */
+	public static Button createCheckBox(Composite parent, String message)=
 {
+		return createCheckBox(parent, message, 1);
+	}
+
+	/**
+	 * Creates a check box with the specified message and span
+	 *=20
+	 * @param parent
+	 * @param message
+	 * @param span
+	 *=20
+	 * @return the created check box
+	 */
+	public static Button createCheckBox(Composite parent, String message,
+			int span) {
+		final Button button =3D new Button(parent, SWT.CHECK);
+		button.setText(message);
+		button.setLayoutData(createHFillGridData(span));
+		return button;
+	}
+
+	/**
+	 * Creates a radio button with the specified message
+	 *=20
+	 * @param parent
+	 * @param message
+	 *=20
+	 * @return the created radio button
+	 */
+	public static Button createRadioButton(Composite parent, String messa=
ge) {
+		return createRadioButton(parent, message, 1);
+	}
+
+	/**
+	 * Creates a radio button with the specified message and span
+	 *=20
+	 * @param parent
+	 * @param message
+	 * @param span
+	 *=20
+	 * @return the created radio button
+	 */
+	public static Button createRadioButton(Composite parent, String messa=
ge,
+			int span) {
+		final Button button =3D new Button(parent, SWT.RADIO);
+		button.setText(message);
+		button.setLayoutData(createHFillGridData(span));
+		return button;
+	}
+
+	/**
+	 * Creates a text control
+	 *=20
+	 * @param parent
+	 *=20
+	 * @return the created text control
+	 */
+	public static Text createText(Composite parent) {
+		return createText(parent, 1);
+	}
+
+	/**
+	 * Creates a text control with the specified span
+	 *=20
+	 * @param parent
+	 * @param span
+	 *=20
+	 * @return the created text control
+	 */
+	public static Text createText(Composite parent, int span) {
+		final Text text =3D new Text(parent, SWT.SINGLE | SWT.BORDER);
+		text.setLayoutData(createHFillGridData(span));
+		return text;
+	}
+
+	/**
+	 * Creates a place holder with the specified height and span
+	 *=20
+	 * @param parent
+	 * @param heightInChars
+	 * @param span
+	 *=20
+	 * @return the created place holder
+	 */
+	public static Control createPlaceholder(Composite parent,
+			int heightInChars, int span) {
+		Assert.isTrue(heightInChars > 0);
+		final Control placeHolder =3D new Composite(parent, SWT.NONE);
+		final GridData gd =3D new GridData(SWT.BEGINNING, SWT.TOP, false, fa=
lse);
+		gd.heightHint =3D new PixelConverter(parent)
+				.convertHeightInCharsToPixels(heightInChars);
+		gd.horizontalSpan =3D span;
+		placeHolder.setLayoutData(gd);
+		return placeHolder;
+	}
+
+	/**
+	 * Creates a place holder with the specified height
+	 *=20
+	 * @param parent
+	 * @param heightInChars
+	 * @return the created place holder
+	 */
+	public static Control createPlaceholder(Composite parent, int heightI=
nChars) {
+		return createPlaceholder(parent, heightInChars, 1);
+	}
+
+	/**
+	 * Creates a pixel converter
+	 *=20
+	 * @param control
+	 *=20
+	 * @return the created pixel converter
+	 */
+	public static PixelConverter createDialogPixelConverter(Control contr=
ol) {
+		Dialog.applyDialogFont(control);
+		return new PixelConverter(control);
+	}
+
+	/**
+	 * Calculates the size of the specified controls, using the specified
+	 * converter
+	 *=20
+	 * @param converter
+	 * @param controls
+	 *=20
+	 * @return the size of the control(s)
+	 */
+	public static int calculateControlSize(PixelConverter converter,
+			Control[] controls) {
+		return calculateControlSize(converter, controls, 0, controls.length =
- 1);
+	}
+
+	/**
+	 * Calculates the size of the specified subset of controls, using the
+	 * specified converter
+	 *=20
+	 * @param converter
+	 * @param controls
+	 * @param start
+	 * @param end
+	 *=20
+	 * @return the created control
+	 */
+	public static int calculateControlSize(PixelConverter converter,
+			Control[] controls, int start, int end) {
+		int minimum =3D converter
+				.convertHorizontalDLUsToPixels(IDialogConstants.BUTTON_WIDTH);
+		for (int i =3D start; i <=3D end; i++) {
+			final int length =3D controls[i]
+					.computeSize(SWT.DEFAULT, SWT.DEFAULT).x;
+			if (minimum < length)
+				minimum =3D length;
+		}
+		return minimum;
+	}
+
+	/**
+	 * Equalizes the specified controls using the specified converter
+	 *=20
+	 * @param converter
+	 * @param controls
+	 */
+	public static void equalizeControls(PixelConverter converter,
+			Control[] controls) {
+		equalizeControls(converter, controls, 0, controls.length - 1);
+	}
+
+	/**
+	 * Equalizes the specified subset of controls using the specified con=
verter
+	 *=20
+	 * @param converter
+	 * @param controls
+	 * @param start
+	 * @param end
+	 */
+	public static void equalizeControls(PixelConverter converter,
+			Control[] controls, int start, int end) {
+		final int size =3D calculateControlSize(converter, controls, start, =
end);
+		for (int i =3D start; i <=3D end; i++) {
+			final Control button =3D controls[i];
+			if (button.getLayoutData() instanceof GridData) {
+				((GridData) button.getLayoutData()).widthHint =3D size;
+			}
+		}
+	}
+
+	/**
+	 * Gets the width of the longest string in <code>strings</code>, usin=
g the
+	 * specified pixel converter
+	 *=20
+	 * @param converter
+	 * @param strings
+	 *=20
+	 * @return the width of the longest string
+	 */
+	public static int getWidthInCharsForLongest(PixelConverter converter,
+			String[] strings) {
+		int minimum =3D 0;
+		for (int i =3D 0; i < strings.length; i++) {
+			final int length =3D converter.convertWidthInCharsToPixels(strings[=
i]
+					.length());
+			if (minimum < length)
+				minimum =3D length;
+		}
+		return minimum;
+	}
+
+	private static class PixelConverter {
+
+		private final FontMetrics fFontMetrics;
+
+		public PixelConverter(Control control) {
+			GC gc =3D new GC(control);
+			try {
+				gc.setFont(control.getFont());
+				fFontMetrics =3D gc.getFontMetrics();
+			} finally {
+				gc.dispose();
+			}
+		}
+
+		public int convertHeightInCharsToPixels(int chars) {
+			return Dialog.convertHeightInCharsToPixels(fFontMetrics, chars);
+		}
+
+		public int convertHorizontalDLUsToPixels(int dlus) {
+			return Dialog.convertHorizontalDLUsToPixels(fFontMetrics, dlus);
+		}
+
+		public int convertVerticalDLUsToPixels(int dlus) {
+			return Dialog.convertVerticalDLUsToPixels(fFontMetrics, dlus);
+		}
+
+		public int convertWidthInCharsToPixels(int chars) {
+			return Dialog.convertWidthInCharsToPixels(fFontMetrics, chars);
+		}
+	}
+}
--=20
1.6.1.2.309.g2ea3
